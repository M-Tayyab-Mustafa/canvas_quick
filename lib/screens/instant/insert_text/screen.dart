import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/model/editing_item.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class InsertTextScreen extends StatefulWidget {
  const InsertTextScreen({super.key, required this.controller, this.fontSize = 18, this.selectedColorIndex = 0, this.selectedFontIndex = 0});
  final TextEditingController controller;
  final double fontSize;
  final int selectedColorIndex;
  final int selectedFontIndex;
  @override
  State<InsertTextScreen> createState() => _InsertTextScreenState();
}

class _InsertTextScreenState extends State<InsertTextScreen> {
  late FocusNode focusNode;
  late int selectedColorIndex;
  late int selectedFontIndex;
  bool colorPaletSelected = true;
  late TextEditingController controller;
  late double fontSize;
  final TextAlign textAlign = TextAlign.center;

  @override
  void initState() {
    focusNode = FocusNode();
    controller = widget.controller;
    fontSize = widget.fontSize;
    selectedColorIndex = widget.selectedColorIndex;
    selectedFontIndex = widget.selectedFontIndex;
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
          textField(),
          verticalSlider(
            fontSize,
            (newFontSize) {
              setState(() {
                fontSize = newFontSize;
              });
            },
          ),
          if (colorPaletSelected)
            CColors(
              index: (index) {
                setState(() {
                  selectedColorIndex = index;
                });
              },
              selectedColorIndex: selectedColorIndex,
            ),
          if (!colorPaletSelected)
            CFonts(
              index: (index) {
                setState(() {
                  selectedFontIndex = index;
                });
              },
              selectedFontIndex: selectedFontIndex,
            ),
          topMenu(),
        ],
      ),
    );
  }

  Widget textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            focusNode.dispose();
            focusNode = FocusNode(canRequestFocus: true);
            focusNode.requestFocus();
          });
        },
        child: Container(
          color: Colors.transparent,
          height: screenSize.height - 50,
          child: Center(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              autofocus: true,
              maxLines: null,
              textAlign: textAlign,
              style: TextStyle(fontSize: fontSize, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex]),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: fontSize, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex]),
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
                  if (colorPaletSelected) {
                    setState(() {
                      colorPaletSelected = false;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: colorPaletSelected ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/text_style.svg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!colorPaletSelected) {
                    setState(() {
                      colorPaletSelected = true;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: !colorPaletSelected ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/color_palete.svg'),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                EditItem(
                  type: EditItemType.text,
                  text: controller.text,
                  fontSize: fontSize,
                  textAlign: textAlign,
                  color: materialColors[selectedColorIndex],
                  fontFamily: fontFamilies[selectedFontIndex],
                  position: Offset((screenSize.width / 2), screenSize.height / 2),
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
