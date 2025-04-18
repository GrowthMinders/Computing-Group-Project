<?php
require __DIR__ . '/vendor/autoload.php';

$price = $_GET['amount'];

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
           ->setTotal((int)($price/296));
    
    $transaction = new Transaction();
    $transaction->setAmount($amount)
                ->setDescription("Meal Matrix Bill Settlement");
    
    $redirectUrls = new RedirectUrls();
    $redirectUrls->setReturnUrl("https://localhost:8080/success")//change
                 ->setCancelUrl("https://localhost:8080/cancel");//change
    
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