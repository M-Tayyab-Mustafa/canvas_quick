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
import 'package:screens/screens/instant/insert_button/screen.dart';
import 'package:screens/screens/instant/insert_text/screen.dart';
import 'package:screens/screens/tags_screen.dart';
import 'package:video_player/video_player.dart';
import '../../../model/editing_item.dart';
import '../../../utils/constants.dart';
import '../../new_instant.dart';
import '../insert_template/screen.dart';

final GlobalKey repaintBoundaryKey = GlobalKey();
bool showDeleteIcon = false;

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, this.imageFile, this.backgroundColor, this.items, this.videoFile});
  final File? imageFile;
  final Color? backgroundColor;
  final File? videoFile;
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
  File? imageFile;
  VideoPlayerController? videoPlayer;

  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;
    items = widget.items ?? [];
    if (widget.videoFile != null) {
      videoPlayer = VideoPlayerController.file(widget.videoFile!);
      videoPlayer!.initialize().whenComplete(() {
        videoPlayer!.play();
        videoPlayer!.setLooping(true);
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: editingHeight,
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
                    if (videoPlayer != null)
                      Center(
                        child: SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          child: AspectRatio(
                            aspectRatio: videoPlayer!.value.aspectRatio,
                            child: VideoPlayer(videoPlayer!),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              Stack(
                                children: items
                                    .map(
                                      (item) => Positioned(
                                        top: item.position.dy,
                                        left: item.position.dx,
                                        child: item.type == EditItemType.text
                                            ? Draggable(
                                                ignoringFeedbackSemantics: false,
                                                rootOverlay: true,
                                                feedback: SizedBox(
                                                  width: item.fontSize * item.text.length > constraints.maxWidth * 0.8
                                                      ? constraints.maxWidth * 0.8
                                                      : item.size!.width > constraints.maxWidth * 0.8
                                                          ? constraints.maxWidth * 0.8
                                                          : null,
                                                  child: Text(
                                                    item.text,
                                                    textAlign: item.textAlign,
                                                    style: TextStyle(fontSize: item.fontSize, color: item.textColor, fontFamily: item.fontFamily, backgroundColor: item.textBackgroundColorIndex != null ? materialColors[item.textBackgroundColorIndex!] : Colors.transparent, height: 0.9),
                                                  ),
                                                ),
                                                childWhenDragging: const Text(''),
                                                onDragUpdate: (details) {
                                                  if (details.globalPosition.dy > constraints.maxHeight - 60) {
                                                    setState(() {
                                                      showDeleteIcon = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      showDeleteIcon = false;
                                                    });
                                                  }
                                                },
                                                onDragEnd: (details) {
                                                  if (details.offset.dy > constraints.maxHeight - 60) {
                                                    onDelete(item);
                                                  } else {
                                                    setState(() {
                                                      item.position = details.offset;
                                                    });
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: item.fontSize * item.text.length > constraints.maxWidth * 0.8
                                                      ? constraints.maxWidth * 0.8
                                                      : item.size!.width > constraints.maxWidth * 0.8
                                                          ? constraints.maxWidth * 0.8
                                                          : null,
                                                  child: InkWell(
                                                    onDoubleTap: () => onDoubleTap(item),
                                                    child: Text(
                                                      item.text,
                                                      textAlign: item.textAlign,
                                                      style: TextStyle(fontSize: item.fontSize, color: item.textColor, fontFamily: item.fontFamily, backgroundColor: item.textBackgroundColorIndex != null ? materialColors[item.textBackgroundColorIndex!] : Colors.transparent, height: 0.9),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Draggable(
                                                feedback: CButton(
                                                  enabled: false,
                                                  backgroundColor: item.backgroundColor!,
                                                  textColor: item.textColor!,
                                                  fontFamily: item.fontFamily,
                                                  selectedShapeIndex: item.selectedButtonShapeIndex!,
                                                  buttonText: item.text,
                                                  fontSize: item.fontSize,
                                                  controller: TextEditingController(text: item.text),
                                                ),
                                                childWhenDragging: const Text(''),
                                                onDragUpdate: (details) {
                                                  if (details.globalPosition.dy + (item.size?.height ?? 0) > constraints.maxHeight - 25) {
                                                    setState(() {
                                                      showDeleteIcon = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      showDeleteIcon = false;
                                                    });
                                                  }
                                                },
                                                onDragEnd: (details) {
                                                  if ((details.offset.dy + (item.size?.height ?? 0)) > constraints.maxHeight - 55) {
                                                    onDelete(item);
                                                  } else {
                                                    setState(() {
                                                      item.position = details.offset;
                                                    });
                                                  }
                                                },
                                                child: InkWell(
                                                  onDoubleTap: () => onDoubleTap(item),
                                                  child: CButton(
                                                    enabled: false,
                                                    backgroundColor: item.backgroundColor!,
                                                    textColor: item.textColor!,
                                                    fontFamily: item.fontFamily,
                                                    selectedShapeIndex: item.selectedButtonShapeIndex!,
                                                    buttonText: item.text,
                                                    fontSize: item.fontSize,
                                                    controller: TextEditingController(text: item.text),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              if (showDeleteIcon)
                                Align(
                                  alignment: const Alignment(0, 1),
                                  child: Container(
                                    height: screenSize.height * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black45),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.delete_forever_rounded,
                                        size: 35,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          if (!insertingText && !insertingButton)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await Permission.storage.request();
                          await Permission.manageExternalStorage.request();
                          var directory = await Directory('/storage/emulated/0/DCIM/Camera').create(recursive: true);
                          await _prepareImage(directoryPath: directory.path, title: 'Saving Image', isSavingImage: true, items: items, defaultImage: widget.imageFile);
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewInstantScreen(
                                              imageFile: File(mediaPath),
                                              items: items,
                                              backgroundColor: widget.backgroundColor,
                                              backgroundImage: widget.imageFile,
                                              backgroundVideoFile: widget.videoFile,
                                            )));
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
            ),
          if (!insertingText && !insertingButton)
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
                            await showGeneralDialog(
                              context: context,
                              pageBuilder: (context, animation, secondaryAnimation) => InsertTextScreen(
                                controller: TextEditingController(),
                              ),
                            ).then((returnValue) {
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
                              builder: (context) => SizedBox(height: screenSize.height, child: const TagScreen(fromEditScreen: true)),
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
                            await showGeneralDialog(
                              context: context,
                              pageBuilder: (context, animation, secondaryAnimation) => InsertTemplate(
                                items: items,
                                backgroundColor: widget.backgroundColor,
                                imageFile: imageFile,
                              ),
                            ).then((returnValue) {
                              if (returnValue != null) {
                                setState(() {
                                  items = returnValue as List<EditItem>;
                                });
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

  onDoubleTap(EditItem item) async {
    int indexOfItem = items.indexOf(items.firstWhere((element) => element == item));
    if (item.type == EditItemType.text) {
      setState(() {
        insertingText = true;
      });
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => InsertTextScreen(
                controller: TextEditingController(text: item.text),
                fontSize: item.fontSize,
                selectedColorIndex: materialColors.indexOf(materialColors.firstWhere((element) => element == item.textColor)),
                selectedFontIndex: fontFamilies.indexOf(fontFamilies.firstWhere((element) => element == item.fontFamily)),
              )).then((returnValue) {
        if (returnValue != null) {
          items.insert(indexOfItem, (returnValue as EditItem).copyWith(position: item.position));
        } else {
          items.insert(indexOfItem, item);
        }
        setState(() {
          insertingText = false;
        });
      });
      items.removeAt(indexOfItem);
    } else {
      setState(() {
        insertingButton = true;
      });
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => InsertButtonScreen(
                product: item.product!,
                buttonText: item.text,
                selectedTextColorIndex: materialColors.indexOf(materialColors.firstWhere((element) => element == item.textColor)),
                selectedColorIndex: materialColors.indexOf(materialColors.firstWhere((element) => element == item.backgroundColor)),
                selectedFontIndex: fontFamilies.indexOf(fontFamilies.firstWhere((element) => element == item.fontFamily)),
                fontSize: item.fontSize,
                selectedShapeIndex: item.selectedButtonShapeIndex!,
              )).then((returnValue) {
        if (returnValue != null) {
          log(returnValue.toString());
          items.insert(indexOfItem, (returnValue as EditItem).copyWith(position: item.position));
        } else {
          items.insert(indexOfItem, item);
        }
        setState(() {
          insertingButton = false;
        });
      });
      items.removeAt(indexOfItem);
    }
  }

  Future<void> onDelete(item) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/cancel_without_background.svg',
                height: 25,
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/icons/delete_bg.svg',
                    height: 110,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Delete the Instant Page?',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'You will not be able to recover it.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color(0xFFFE2B54)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Color(0xFFFE2B54)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFFE2B54)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(Color(0xFFFE2B54)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Yes, Delete it.',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    ).then((value) {
      if (value != null && value) {
        setState(() {
          items.removeAt(items.indexOf(items.firstWhere((element) => element == item)));
        });
      }
      setState(() {
        showDeleteIcon = false;
      });
    });
  }

  @override
  void dispose() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    super.dispose();
  }

  Future<String?> _prepareImage({
    required String directoryPath,
    required String title,
    bool isSavingImage = false,
    File? defaultImage,
    List<EditItem> items = const <EditItem>[],
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
          'items': jsonEncode(items.map((e) => e.toMap()).toList()),
          'background_image': widget.imageFile?.path ?? '',
          'background_color': widget.backgroundColor?.value.toString() ?? '',
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
}
