// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:screens/model/product.dart';
import 'package:screens/model/template.dart';
import 'package:screens/screens/instant/insert_button/screen.dart';
import 'package:screens/screens/instant/insert_text/screen.dart';
import 'package:screens/screens/sudio_main.dart';
import 'package:screens/screens/tags_screen.dart';
import '../../../model/editing_item.dart';
import '../../../utils/constants.dart';
import '../insert_template/screen.dart';

final GlobalKey repaintBoundaryKey = GlobalKey();

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, this.imageFile, this.backgroundColor, this.items});
  final File? imageFile;
  final Color? backgroundColor;
  final List<EditItem>? items;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final primaryColor = const Color(0xFF622CEA);
  final secondaryColor = const Color(0xFF27262A);
  late List<EditItem> items;
  bool insertingText = false;
  bool insertingButton = false;
  bool insertingTemplate = false;
  File? imageFile;
  CTemplate? cTemplate;

  @override
  void initState() {
    imageFile = widget.imageFile;
    items = widget.items ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: RepaintBoundary(
                  key: repaintBoundaryKey,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: [
                        if (widget.backgroundColor != null)
                          Center(
                            child: Container(
                              color: widget.backgroundColor,
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                            ),
                          ),
                        if (imageFile != null)
                          Center(
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.fill,
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                            ),
                          ),
                        if (cTemplate != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 10),
                            child: Align(
                              alignment: cTemplate!.alignment,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: items
                                    .map(
                                      (item) => item.type == EditItemType.text
                                          ? ItemTextWidget(item: item)
                                          : item.type == EditItemType.button
                                              ? CButton(color: item.color!, fontFamily: item.fontFamily!, selectedShapeIndex: item.selectedButtonShapeIndex!)
                                              : Container(),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            width: screenSize.width,
                            child: EditItems(items: items),
                          ),
                      ],
                    );
                  }),
                ),
              ),
              if (!insertingText && !insertingButton && !insertingTemplate)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await Permission.storage.request();
                            await Permission.manageExternalStorage.request();
                            var directory = await Directory('/storage/emulated/0/Pictures').create(recursive: true);
                            await _prepareImage(directoryPath: directory.path, title: 'Saving Image', isSavingImage: true);
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: primaryColor, width: 1)),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await _prepareImage(directoryPath: (await getTemporaryDirectory()).path, title: 'Processing Image').then((mediaPath) {
                                if (mediaPath != null) {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => SizedBox(height: screenSize.height, child: StudioMain(imageFile: File(mediaPath), items: items)),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Failed to save image'),
                                    ),
                                  );
                                }
                              });
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (insertingTemplate) SizedBox(height: screenSize.height * 0.2),
            ],
          ),
          if (!insertingText && !insertingButton && !insertingTemplate)
            Align(
              alignment: const Alignment(0, -0.9),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF27262A),
                        ),
                        child: const Align(
                          alignment: Alignment(-0.15, 0),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (imageFile != null)
                          GestureDetector(
                            onTap: () async {
                              var imageCropper = ImageCropper();
                              var coppedFile = await imageCropper.cropImage(
                                sourcePath: imageFile!.path,
                                uiSettings: [
                                  AndroidUiSettings(
                                    hideBottomControls: true,
                                  ),
                                ],
                              );
                              if (coppedFile != null) {
                                setState(() {
                                  imageFile = File(coppedFile.path);
                                  insertingText = false;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF27262A),
                              ),
                              child: Center(child: SvgPicture.asset('assets/icons/shape.svg')),
                            ),
                          ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              insertingText = true;
                            });
                            await showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) => const InsertTextScreen()).then((returnValue) {
                              if (returnValue != null) {
                                items.add(returnValue as EditItem);
                              }
                              setState(() {
                                insertingText = false;
                              });
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF27262A),
                            ),
                            child: Center(child: SvgPicture.asset('assets/icons/text.svg')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SizedBox(height: screenSize.height, child: const TagScreen()),
                            ).then((response) async {
                              if (response != null) {
                                if (response.runtimeType == Product) {
                                  (response as Product);
                                  setState(() {
                                    insertingButton = true;
                                  });
                                  await showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) => InsertButtonScreen(product: response)).then((returnValue) {
                                    if (returnValue != null) {
                                      items.add(returnValue as EditItem);
                                    }
                                    setState(() {
                                      insertingButton = false;
                                    });
                                  });
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF27262A),
                            ),
                            child: Center(child: SvgPicture.asset('assets/icons/sticker.svg')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              insertingTemplate = true;
                            });
                            await showGeneralDialog(
                                context: context,
                                pageBuilder: (context, animation, secondaryAnimation) => InsertTemplate(
                                      items: items,
                                      backgroundColor: widget.backgroundColor,
                                      imageFile: imageFile,
                                      cTemplate: cTemplate,
                                    )).then((returnValue) {
                              setState(() {
                                if (returnValue != null) {
                                  cTemplate = returnValue as CTemplate;
                                }
                                insertingTemplate = false;
                              });
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF27262A),
                            ),
                            child: Center(child: SvgPicture.asset('assets/icons/table.svg')),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Future<String?> _prepareImage({
  required String directoryPath,
  required String title,
  bool isSavingImage = false,
}) async {
  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);
  progressNotifier.addListener(() {
    EasyLoading.showProgress(
      progressNotifier.value,
      status: '$title ${progressNotifier.value * 100}',
    );
    if (progressNotifier.value == 1) {
      EasyLoading.dismiss();
    }
  });
  ByteData? byteData;

  try {
    progressNotifier.value = 0.1; // 10% - Start processing

    RenderRepaintBoundary? boundary = repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    progressNotifier.value = 0.2; // 20% - Boundary found

    ui.Image? image = await boundary?.toImage(pixelRatio: 4);
    progressNotifier.value = 0.4; // 40% - Image captured

    byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    progressNotifier.value = 0.6; // 60% - Image data fetched

    Uint8List bytes = byteData!.buffer.asUint8List();
    progressNotifier.value = 0.7; // 70% - Byte data converted
    String imgPath = '$directoryPath/shot_${DateTime.now().toIso8601String().split('T').first}T${DateTime.now().toIso8601String().split('T').last.replaceAll(':', '_').split('.').first}.jpg';
    File imgFile = File(imgPath);
    await imgFile.writeAsBytes(bytes);

    if (isSavingImage) {
      String base64Image = base64Encode(imgFile.readAsBytesSync());

      Map<String, String> jsonMap = {
        'image': base64Image,
      };
      String jsonString = jsonEncode(jsonMap);
      Directory appDocDir = (await getExternalStorageDirectory())!;
      String filePath = '${appDocDir.path}/shot_${DateTime.now().toIso8601String().split('T').first}T${DateTime.now().toIso8601String().split('T').last.replaceAll(':', '_').split('.').first}.json';
      File jsonFile = File(filePath);
      await jsonFile.writeAsString(jsonString);
      log(jsonFile.path);
    }
    // Save JSON to file

    progressNotifier.value = 1.0; // 100% - Image saved
    return imgFile.path;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
