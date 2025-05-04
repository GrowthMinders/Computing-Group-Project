// ignore_for_file: file_names, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mealmatrix/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/Home.dart';
import 'dart:developer';
import 'dart:ui'; // For BackdropFilter

import 'package:mealmatrix/main.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String supply;
  final String canteen;
  const ProductDetail({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.supply,
    required this.canteen,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  int qty = 1;
  bool isFavorite = false; // Track favorite state

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus(); // Check if the item is already favorited on page load
  }

  // Method to check if the item is already in favorites
  Future<void> checkFavoriteStatus() async {
    try {
      var url = Uri.parse(
        "http://192.168.8.101/Firebase/checkfavorite.php",
      );

      var response = await http.post(
        url,
        body: {
          'name': widget.name,
          'supply': widget.supply,
          'canteen': widget.canteen,
          'user': Logdata.userEmail,
        },
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a JSON with a boolean "isFavorited"
        var result = response.body;
        setState(() {
          isFavorite = result.contains(
              "true"); // Simplified check; adjust based on actual API response
        });
      }
    } catch (ex) {
      log("Error checking favorite status: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/Meal Matrix Logo.png'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                widget.price,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Supply:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                widget.supply,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Canteen:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                widget.canteen,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.teal,
                                ),
                                onPressed: () async {
                                  // Toggle immediately for instant feedback
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });

                                  try {
                                    var url = Uri.parse(
                                      "http://192.168.8.101/Firebase/favorite.php",
                                    );

                                    var response = await http.post(
                                      url,
                                      body: {
                                        'name': widget.name,
                                        'supply': widget.supply,
                                        'canteen': widget.canteen,
                                        'user': Logdata.userEmail,
                                      },
                                    );

                                    if (response.statusCode == 204) {
                                      // If already favorited, toggle back (assuming API toggles favorite status)
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'This product is already in your favorites',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } catch (ex) {
                                    log("Unexpected error: $ex");
                                    // Revert the toggle on error
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.teal.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.remove, color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  if (qty > 1) {
                                    qty--;
                                  }
                                });
                              },
                            ),
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.teal),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  qty++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            var url = Uri.parse(
                              "http://192.168.8.101/Firebase/cart.php",
                            );

                            var response = await http.post(
                              url,
                              body: {
                                'name': widget.name,
                                'price': widget.price.toString(),
                                'supply': widget.supply,
                                'canteen': widget.canteen,
                                'quantity': qty.toString(),
                                'user': Logdata.userEmail,
                              },
                            );

                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          "Add To Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
