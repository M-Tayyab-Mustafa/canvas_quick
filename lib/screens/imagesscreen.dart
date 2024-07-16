// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:screens/screens/instant/edit/screen.dart';

import '../utils/constants.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  Color currentColor = Colors.white;
  bool isPickingColor = true;
  final List<String> images = [
    "assets/images/image1.jpeg",
    "assets/images/image2.jpeg",
    "assets/images/image3.jpeg",
    "assets/images/image4.jpeg",
    "assets/images/image5.jpeg",
    "assets/images/image6.jpeg",
    "assets/images/image7.jpeg",
    "assets/images/image8.jpeg",
    "assets/images/image9.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * .09,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPickingColor = true;
                        });
                      },
                      child: Container(
                        width: screenSize.width * .24,
                        height: screenSize.height * .1,
                        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: screenSize.width * .06,
                              height: screenSize.height * .03,
                              color: Colors.white,
                            ),
                            const Text(
                              "Solid",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isPickingColor = false;
                        });
                        await ImagePicker().pickImage(source: ImageSource.gallery).then((imageFile) {
                          if (imageFile != null) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SizedBox(height: screenSize.height, child: EditScreen(imageFile: File(imageFile.path))),
                            );
                          }
                        });
                      },
                      child: Container(
                        width: screenSize.width * .24,
                        height: screenSize.height * .1,
                        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            Text(
                              "Image",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPickingColor = false;
                        });
                      },
                      child: Container(
                        width: screenSize.width * .24,
                        height: screenSize.height * .1,
                        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ondemand_video_sharp,
                              color: Colors.white,
                            ),
                            Text(
                              "Video",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                if (isPickingColor)
                  SizedBox(
                    height: screenSize.height * 0.8,
                    width: screenSize.width,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: ColorPicker(
                            onColorChanged: (value) => currentColor = value,
                            pickerColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(Color(0xFF622CEA)),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SizedBox(height: screenSize.height, child: EditScreen(backgroundColor: currentColor)),
                                );
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 0.56,
                      children: List.generate(images.length, (index) {
                        return Container(
                          height: screenSize.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                images[index],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
