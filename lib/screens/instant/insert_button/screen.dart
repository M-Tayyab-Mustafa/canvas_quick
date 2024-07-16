import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/model/editing_item.dart';
import 'package:screens/model/product.dart';
import 'package:screens/utils/constants.dart';

class InsertButtonScreen extends StatefulWidget {
  const InsertButtonScreen({super.key, required this.product});
  final Product product;

  @override
  State<InsertButtonScreen> createState() => _InsertButtonScreenState();
}

class _InsertButtonScreenState extends State<InsertButtonScreen> {
  var selectedColorIndex = 2;
  var selectedFontIndex = 0;
  var selectedShapeIndex = 2;
  var colorPaletIndex = 2;

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
              CButton(selectedShapeIndex: selectedShapeIndex, color: materialColors[selectedColorIndex], fontFamily: fontFamilies[selectedFontIndex]),
              if (colorPaletIndex == 0)
                CButtonShape(
                    index: (index) {
                      setState(() {
                        selectedShapeIndex = index;
                      });
                    },
                    color: materialColors[selectedColorIndex],
                    selectedShapeIndex: selectedShapeIndex),
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
              ProductCard(product: widget.product),
              topMenu(),
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
            Navigator.pop(
              context,
              EditItem(
                type: EditItemType.button,
                position: Offset(0, screenSize.height / 2),
                fontFamily: fontFamilies[selectedFontIndex],
                color: materialColors[selectedColorIndex],
                selectedButtonShapeIndex: selectedShapeIndex,
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
