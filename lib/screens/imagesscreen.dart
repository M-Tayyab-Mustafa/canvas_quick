// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  @override
  void initState() {
    super.initState();
    _getImages();
  }

  List<String> fileImages = [];

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
                        await Permission.storage.request();
                        await Permission.manageExternalStorage.request();
                        _getImages();
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(backgroundColor: currentColor))).whenComplete(() => _getImages());
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
                    child: fileImages.isEmpty
                        ? Center(
                            child: Text(
                              'Image Not Available',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                              crossAxisCount: 3,
                            ),
                            itemCount: fileImages.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(imageFile: File(fileImages[index])))).whenComplete(() => _getImages()),
                              child: Container(
                                height: screenSize.height * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(
                                      File(fileImages[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImages() async {
    var directory = Directory('/storage/emulated/0/DCIM/Camera');

    if (await directory.exists()) {
      fileImages = directory
          .listSync()
          .where(
            (file) => file.path.endsWith('.jpg') || file.path.endsWith('.jpeg') || file.path.endsWith('.png') || file.path.endsWith('.gif'),
          )
          .toList()
          .map((e) => e.path)
          .toList();

      setState(() {});
    }
  }
}
