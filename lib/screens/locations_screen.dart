import 'package:flutter/material.dart';

import '../model/product.dart';
import '../utils/constants.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                          hintText: 'Search Location',
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
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemSCreen()));
                    },
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: screenSize.width * .9,
                  height: screenSize.height * .1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade800,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * .6,
                          child: const Text(
                            "To find nearby place, Please turn on location services.",
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: screenSize.width * .21,
                          height: screenSize.height * .045,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.pink,
                          ),
                          child: const Center(
                            child: Text(
                              "Turn On",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Custom TabBar
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabSelected(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'For You',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          if (_selectedTabIndex == 0)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              height: 2,
                              width: 130,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabSelected(1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Browse',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          if (_selectedTabIndex == 1)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              height: 2,
                              width: 130,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Tab Content
              Expanded(
                child: _selectedTabIndex == 0
                    ? SingleChildScrollView(
                        child: Column(
                          children: products
                              .map<Widget>(
                                (product) => ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context, product);
                                  },
                                  title: Text(
                                    product.title,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    product.subTitle,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Browse data',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Product> products = [
    Product(title: 'Kuala Lumpur City Centre', subTitle: 'Kuala Lumpur, 5000, Malasia', productType: ProductType.location),
    Product(title: 'Pavilion Kuala Lumpur', subTitle: 'Kuala Lumpur, 5000, Malasia', productType: ProductType.location),
    Product(title: 'Mid Valley Megamall', subTitle: 'KBander Utama , PEtaling jaya,47800,Malaysia', productType: ProductType.location),
    Product(title: 'Publika', subTitle: 'Solaris Dutamas, Kuala Lumpr,50000,Malaysia', productType: ProductType.location),
    Product(title: 'TRX Shopping Gallary', subTitle: 'TRX,Kuala Lumpur 50000, Malaysia', productType: ProductType.location),
    Product(title: 'IKEA Ikano Power Centre', subTitle: 'Mutiara Damansora,Petaling jaya, 47000,Malaysia', productType: ProductType.location),
    Product(title: 'Jalan Alor', subTitle: 'Kuala Lumpur, 5000, Malasia', productType: ProductType.location),
    Product(title: 'Kuala Lumpur City Centre', subTitle: 'Kuala Lumpur 50000, Malaysia', productType: ProductType.location),
  ];
}
