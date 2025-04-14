// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mealmatrix/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/Home.dart';
import 'dart:developer';

import 'package:mealmatrix/main.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String supply;
  final String canteen;
  const ProductDetail({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.supply,
    required this.canteen,
  });

  @override
  State<ProductDetail> createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        widget.image,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.supply, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.canteen,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () async {
                      try {
                        var url = Uri.parse(
                          "http://192.168.177.67/Firebase/favorite.php",
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
                          ScaffoldMessenger.of(context).showSnackBar(
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
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (qty > 1) {
                                qty--;
                              }
                            });
                          },
                        ),
                        Text(qty.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              qty++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        var url = Uri.parse(
                          "http://192.168.177.67/Firebase/cart.php",
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
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
