import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'products_screen.dart';
import 'locations_screen.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
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
                          hintText: 'Search',
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
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SizedBox(height: screenSize.height, child: const ProductsScreen()),
                      );
                    },
                    child: Container(
                      width: screenSize.width * .28,
                      height: screenSize.height * .05,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alternate_email_outlined,
                            color: Colors.red,
                          ),
                          Text("Product")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width * .3,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_repair_service,
                          color: Colors.green,
                        ),
                        Text(
                          "Service",
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width * .3,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.headset_mic_rounded,
                          color: Colors.blue,
                        ),
                        Text("Chat")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SizedBox(height: screenSize.height, child: const LocationsScreen()),
                      );
                    },
                    child: Container(
                      width: screenSize.width * .3,
                      height: screenSize.height * .05,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.red,
                          ),
                          Text("Location")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.height * .01,
                  ),
                  Container(
                    width: screenSize.width * .3,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.redAccent,
                        ),
                        Text("Show Only")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenSize.width * .28,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sticky_note_2_rounded,
                          color: Colors.deepPurple,
                        ),
                        Text("Tickets")
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width * .3,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                        Text(
                          "Image",
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width * .3,
                    height: screenSize.height * .05,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          color: Colors.blue,
                        ),
                        Text("Frame")
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
