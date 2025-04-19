<?php
require __DIR__ . '/vendor/autoload.php';

$price = urldecode($_GET['amount']);
//Payment Unsucess data setting
include_once "connection.php";
$conid = "";
$sql2 = "SELECT MAX(iid) AS lastid FROM invoice";
$result2 = sqlsrv_query($conn, $sql2);
if($row2 = sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)) {
    $conid = $row2["lastid"]+1;
}

date_default_timezone_set('Asia/Colombo');
$today = date('d/m/Y');  

$value = (int)($price/296);

$cancelUrl = "http://192.168.177.67/FireBase/state/paymentunsuccess.php?" . http_build_query([
    'oid' => $conid,
    'date' => $today,
    'price' => $price
]);


//Payment sucess data setting
$products = urldecode($_GET['data']);
$email = urldecode($_GET['email']); 
$qty = urldecode($_GET['qdata']);

$returnUrl = "http://192.168.177.67/FireBase/state/cashpayment.php?" . http_build_query([
    'pid' => $products,
    'email' => $email,
    'price' => $value,
    'qty' => $qty
]);


//Payment Proceedure
use PayPal\Api\Amount;
use PayPal\Api\Payer;
use PayPal\Api\Payment;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Transaction;
use PayPal\Rest\ApiContext;
use PayPal\Auth\OAuthTokenCredential;

define('CLIENT_ID', 'AY4arn0ueXTF5Daoe9KG2upOh6ziRLLzFQUUl2Q3Ha76Km9se96rPGbH-DdeGSdhFnlMfdcjFFuIlwkk');
define('CLIENT_SECRET', 'ECQwlaV7quHuUrepzunO06a4TD84VbiU-ckHIhYkezYxqSPGEijv71uhQXlNTx-a2-ecOuKOM_W4jHGk');
define('MODE', 'sandbox');

if ($price <= 0) {
    http_response_code(400);
    die("Amount must be greater than zero");
}

try {
    $payer = new Payer();
    $payer->setPaymentMethod("paypal");
    
    $amount = new Amount();
    $amount->setCurrency("USD")
           ->setTotal($value);
    
    $transaction = new Transaction();
    $transaction->setAmount($amount)
                ->setDescription("Meal Matrix Bill Settlement");
    
    $redirectUrls = new RedirectUrls();
    $redirectUrls->setReturnUrl($returnUrl)
                 ->setCancelUrl($cancelUrl);
    
    $payment = new Payment();
    $payment->setIntent("sale")
            ->setPayer($payer)
            ->setTransactions([$transaction])
            ->setRedirectUrls($redirectUrls);
    
    $apiContext = new ApiContext(
        new OAuthTokenCredential(CLIENT_ID, CLIENT_SECRET)
    );
    $apiContext->setConfig(['mode' => MODE]);
    
    $payment->create($apiContext);
    
    $approvalUrl = null;
    foreach ($payment->getLinks() as $link) {
        if ($link->getRel() == 'approval_url') {
            $approvalUrl = $link->getHref();
            break;
        }
    }
    
    if (!$approvalUrl) {
        throw new Exception("No approval URL found");
    }
    
    header("Location: " . $approvalUrl);
    exit();
    
} catch (Exception $e) {
    error_log("Payment failed: " . $e->getMessage());
    http_response_code(500);
    echo "Payment processing failed. Please try again later.";
}