import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/model/editing_item.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class InsertTextScreen extends StatefulWidget {
  const InsertTextScreen({super.key});

  @override
  State<InsertTextScreen> createState() => _InsertTextScreenState();
}

class _InsertTextScreenState extends State<InsertTextScreen> {
  late FocusNode focusNode;
  var controller = TextEditingController();
  double fontSize = 18;
  var selectedColorIndex = 0;
  var selectedFontIndex = 0;
  bool colorPaletSelected = true;
  final TextAlign textAlign = TextAlign.center;

  @override
  void initState() {
    focusNode = FocusNode();
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          textField(),
          verticalSlider(),
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

  Widget verticalSlider() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 20,
        height: screenSize.height * 0.35,
        child: SfSlider.vertical(
          min: 12,
          max: 60,
          value: fontSize,
          activeColor: const Color(0xFF919191),
          inactiveColor: Colors.white,
          thumbIcon: SizedBox(
            child: Center(
              child: Text(
                fontSize.toInt().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          showLabels: false,
          onChanged: (newFontSize) {
            setState(() {
              fontSize = newFontSize;
            });
          },
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
