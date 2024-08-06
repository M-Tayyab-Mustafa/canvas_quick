import 'package:flutter/material.dart';
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
    this.selectedTextColorIndex = 2,
  });
  final Product product;
  final int selectedColorIndex;
  final int selectedTextColorIndex;
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
  late int selectedTextColorIndex;
  late int selectedFontIndex;
  late int selectedShapeIndex;
  late int colorPaletIndex;
  late String buttonText;
  late double fontSize;
  late Product product;
  final GlobalKey buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedColorIndex = widget.selectedColorIndex;
    selectedTextColorIndex = widget.selectedTextColorIndex;
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
              Center(
                child: CButton(
                  key: buttonKey,
                  textColor: materialColors[selectedTextColorIndex],
                  selectedShapeIndex: selectedShapeIndex,
                  backgroundColor: materialColors[selectedColorIndex],
                  fontFamily: fontFamilies[selectedFontIndex],
                  buttonText: buttonText,
                  fontSize: fontSize,
                  controller: TextEditingController(text: buttonText),
                  onChange: (value) {
                    setState(() {
                      buttonText = value;
                    });
                  },
                ),
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
              if (colorPaletIndex == 3)
                CColors(
                    index: (index) {
                      setState(() {
                        selectedTextColorIndex = index;
                      });
                    },
                    selectedColorIndex: selectedTextColorIndex),
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
            GestureDetector(
              onTap: () {
                setState(() {
                  colorPaletIndex = 3;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorPaletIndex != 3 ? Colors.transparent : const Color(0xFF27262A), shape: BoxShape.circle),
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
                key: buttonKey,
                type: EditItemType.button,
                position: Offset((screenSize.width * 0.5) - (buttonWidth * 0.5), (screenSize.height - 90) * 0.5),
                fontFamily: fontFamilies[selectedFontIndex],
                textColor: materialColors[selectedTextColorIndex],
                backgroundColor: materialColors[selectedColorIndex],
                selectedButtonShapeIndex: selectedShapeIndex,
                text: buttonText,
                fontSize: fontSize,
                product: product,
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
