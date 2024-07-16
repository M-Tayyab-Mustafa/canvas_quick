// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../utils/constants.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: kTextTabBarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: screenSize.height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade800,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Search Products',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "For You",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      "See More",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: products
                      .map<Widget>(
                        (product) => ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context, product);
                          },
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              image: DecorationImage(
                                image: AssetImage(product.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(product.title, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(product.subTitle, style: const TextStyle(color: Colors.white)),
                          trailing: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Product> products = [
    Product(title: 'Mail Box', subTitle: 'MB-203998A', image: 'assets/images/box1.png', productType: ProductType.product),
    Product(title: 'Regular Sloted Corten', subTitle: 'RSC-6009-4A', image: 'assets/images/22.jpeg', productType: ProductType.product),
    Product(title: 'Top Bottom Storage Box', subTitle: 'TBSB-8900-2C', image: 'assets/images/33.jpeg', productType: ProductType.product),
    Product(title: 'Paper Sheets', subTitle: 'PS-356688', image: 'assets/images/44.jpeg', productType: ProductType.product),
    Product(title: 'Archive Box', subTitle: 'Ab-66534-NP', image: 'assets/images/55.jpeg', productType: ProductType.product),
    Product(title: 'OFFset Printing Box', subTitle: 'OFP-67800-4C', image: 'assets/images/66.jpeg', productType: ProductType.product),
    Product(title: 'Full Color Printing Box', subTitle: 'FCPB-8800998-3C', image: 'assets/images/77.jpeg', productType: ProductType.product),
  ];
}
