import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/model/editing_item.dart';
import 'package:screens/model/product.dart';
import 'package:screens/utils/constants.dart';

import '../../tags_screen.dart';

class InsertButtonScreen extends StatefulWidget {
  const InsertButtonScreen({
    super.key,
    required this.product,
    this.buttonText = '',
    this.selectedColorIndex = 4,
    this.selectedFontIndex = 0,
    this.selectedShapeIndex = 2,
    this.colorPaletIndex = 2,
    this.fontSize = 18,
  });
  final Product product;
  final int selectedColorIndex;
  final int selectedFontIndex;
  final int selectedShapeIndex;
  final int colorPaletIndex;
  final String buttonText;
  final double fontSize;
  @override
  State<InsertButtonScreen> createState() => _InsertButtonScreenState();
}

class _InsertButtonScreenState extends State<InsertButtonScreen> {
  late int selectedColorIndex;
  late int selectedFontIndex;
  late int selectedShapeIndex;
  late int colorPaletIndex;
  late String buttonText;
  late double fontSize;
  late Product product;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedColorIndex = widget.selectedColorIndex;
    selectedFontIndex = widget.selectedFontIndex;
    selectedShapeIndex = widget.selectedShapeIndex;
    colorPaletIndex = widget.colorPaletIndex;
    buttonText = widget.buttonText;
    fontSize = widget.fontSize;
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414).withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(100, 100),
                child: RepaintBoundary(
                  key: key,
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: fontFamilies[selectedFontIndex],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              CButton(
                selectedShapeIndex: selectedShapeIndex,
                color: materialColors[selectedColorIndex],
                fontFamily: fontFamilies[selectedFontIndex],
                buttonText: buttonText,
                fontSize: fontSize,
                controller: TextEditingController(text: buttonText),
                onChange: (value) {
                  log(value);
                  setState(() {
                    buttonText = value;
                  });
                },
              ),
              if (colorPaletIndex == 0)
                CButtonShape(
                  index: (index) {
                    setState(() {
                      selectedShapeIndex = index;
                    });
                  },
                  color: materialColors[selectedColorIndex],
                  selectedShapeIndex: selectedShapeIndex,
                ),
              if (colorPaletIndex == 1)
                CFonts(
                    index: (index) {
                      setState(() {
                        selectedFontIndex = index;
                      });
                    },
                    selectedFontIndex: selectedFontIndex),
              if (colorPaletIndex == 2)
                CColors(
                    index: (index) {
                      setState(() {
                        selectedColorIndex = index;
                      });
                    },
                    selectedColorIndex: selectedColorIndex),
              GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => SizedBox(height: screenSize.height, child: const TagScreen(fromEditScreen: true)),
                  ).then((response) async {
                    if (response != null) {
                      if (response.runtimeType == Product) {
                        setState(() {
                          product = (response as Product);
                        });
                      }
                    }
                  });
                },
                child: ProductCard(product: product),
              ),
              topMenu(),
              verticalSlider(
                fontSize,
                (newFontSize) {
                  setState(() {
                    fontSize = newFontSize;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topMenu() {
    return Row(
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
                  colorPaletIndex = 0;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorPaletIndex != 0 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                child: SvgPicture.asset('assets/icons/shape_palet.svg'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  colorPaletIndex = 1;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorPaletIndex != 1 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                child: SvgPicture.asset('assets/icons/text_style.svg'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  colorPaletIndex = 2;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorPaletIndex != 2 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
                child: SvgPicture.asset('assets/icons/color_palete.svg'),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
            log(boundary!.size.toString());
            Navigator.pop(
              context,
              EditItem(
                key: key,
                type: EditItemType.button,
                position: Offset((screenSize.width * 0.5) - ((screenSize.width * 0.8) / 2), screenSize.height / 2),
                fontFamily: fontFamilies[selectedFontIndex],
                color: materialColors[selectedColorIndex],
                selectedButtonShapeIndex: selectedShapeIndex,
                text: buttonText,
                fontSize: fontSize,
                product: product,
                size: Size(screenSize.width * 0.7, boundary.size.height * 2),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
