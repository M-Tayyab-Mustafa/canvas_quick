import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/model/editing_item.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class InsertTextScreen extends StatefulWidget {
  const InsertTextScreen({super.key, required this.controller, this.fontSize = 18, this.selectedColorIndex = 0, this.selectedFontIndex = 0, this.selectedTextAlignIndex = 0, this.selectedTextBackgroundColorIndex = 1});
  final TextEditingController controller;
  final double fontSize;
  final int selectedColorIndex;
  final int selectedFontIndex;
  final int selectedTextAlignIndex;
  final int selectedTextBackgroundColorIndex;
  @override
  State<InsertTextScreen> createState() => _InsertTextScreenState();
}

class _InsertTextScreenState extends State<InsertTextScreen> {
  late FocusNode focusNode;
  late int selectedColorIndex;
  late int selectedFontIndex;
  int selectedPaletIndex = 1;
  late TextEditingController controller;
  late double fontSize;
  String text = '';
  late int selectedTextAlignIndex;
  late int selectedTextBackgroundColorIndex;
  final GlobalKey textKey = GlobalKey();

  @override
  void initState() {
    focusNode = FocusNode();
    controller = widget.controller;
    fontSize = widget.fontSize;
    selectedColorIndex = widget.selectedColorIndex;
    selectedFontIndex = widget.selectedFontIndex;
    selectedTextAlignIndex = widget.selectedTextAlignIndex;
    selectedTextBackgroundColorIndex = widget.selectedTextBackgroundColorIndex;
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(-99, 99),
            child: Text(
              text,
              key: textKey,
              textAlign: textAligns[selectedTextAlignIndex],
              style: TextStyle(fontSize: fontSize, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex], backgroundColor: materialColors[selectedTextBackgroundColorIndex], height: 0.9),
            ),
          ),
          textField(),
          verticalSlider(
            fontSize,
            (newFontSize) {
              setState(() {
                fontSize = newFontSize;
              });
            },
          ),
          if (selectedPaletIndex == 1)
            CColors(
              index: (index) {
                setState(() {
                  selectedColorIndex = index;
                });
              },
              selectedColorIndex: selectedColorIndex,
            ),
          if (selectedPaletIndex == 0)
            CFonts(
              index: (index) {
                setState(() {
                  selectedFontIndex = index;
                });
              },
              selectedFontIndex: selectedFontIndex,
            ),
          if (selectedPaletIndex == 2)
            CColors(
              index: (index) {
                setState(() {
                  selectedTextBackgroundColorIndex = index;
                });
              },
              selectedColorIndex: selectedTextBackgroundColorIndex,
            ),
          topMenu(),
        ],
      ),
    );
  }

  Widget textField() {
    return GestureDetector(
      onTap: () {
        setState(() {
          focusNode.dispose();
          focusNode = FocusNode(canRequestFocus: true);
          focusNode.requestFocus();
        });
      },
      child: Center(
        child: Container(
          color: Colors.transparent,
          height: screenSize.height - 50,
          width: screenSize.width * 0.85,
          child: Center(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              autofocus: true,
              maxLines: null,
              textAlign: textAligns[selectedTextAlignIndex],
              style: TextStyle(fontSize: fontSize, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex], backgroundColor: materialColors[selectedTextBackgroundColorIndex], height: 0.9),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: fontSize, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex], backgroundColor: materialColors[selectedTextBackgroundColorIndex], height: 0.9),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/cancel.svg',
                height: 40,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaletIndex = 0;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: selectedPaletIndex != 0 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/text_style.svg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaletIndex = 1;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: selectedPaletIndex != 1 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/color_palete.svg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaletIndex = 2;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: selectedPaletIndex != 2 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                  child: const Icon(
                    Icons.text_fields,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedTextAlignIndex == 0) {
                      setState(() {
                        selectedTextAlignIndex = 1;
                      });
                    } else if (selectedTextAlignIndex == 1) {
                      setState(() {
                        selectedTextAlignIndex = 2;
                      });
                    } else if (selectedTextAlignIndex == 2) {
                      setState(() {
                        selectedTextAlignIndex = 3;
                      });
                    } else {
                      setState(() {
                        selectedTextAlignIndex = 0;
                      });
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Color(0xFF27262A), shape: BoxShape.circle),
                  child: Icon(
                    selectedTextAlignIndex == 0
                        ? Icons.format_align_center
                        : selectedTextAlignIndex == 1
                            ? Icons.format_align_justify
                            : selectedTextAlignIndex == 2
                                ? Icons.format_align_left
                                : Icons.format_align_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              text = controller.text;
              setState(() {});
              final RenderBox? renderBox = textKey.currentContext?.findRenderObject() as RenderBox?;
              Navigator.pop(
                context,
                EditItem(
                  key: GlobalKey(),
                  type: EditItemType.text,
                  text: controller.text,
                  fontSize: fontSize,
                  textAlign: textAligns[selectedTextAlignIndex],
                  color: materialColors[selectedColorIndex],
                  fontFamily: fontFamilies[selectedFontIndex],
                  position: Offset((screenSize.width * 0.5) - (renderBox!.size.width * 0.5), (screenSize.height - 90) * 0.5),
                  textBackgroundColorIndex: selectedTextBackgroundColorIndex,
                  textSize: renderBox.size,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF27262A), borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
