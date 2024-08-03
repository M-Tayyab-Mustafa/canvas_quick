import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/model/product.dart';
import 'package:screens/model/template.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../model/audience.dart';

late Size screenSize;
double buttonWidth = screenSize.width * 0.5;
double editingHeight = screenSize.height - 90;

enum EditItemType { button, text, other }

enum ProductType { product, location }

List<CTemplate> templates = [
  CTemplate(alignment: Alignment.bottomLeft, textAlign: TextAlign.left, name: 'Vermont', position: Offset(16, screenSize.height - (screenSize.height * 0.41))),
  CTemplate(alignment: Alignment.center, textAlign: TextAlign.center, name: 'Minimalist', position: Offset(0, screenSize.height)),
];

List<Audience> audiences = [
  Audience(title: 'Public', subTitle: 'Open To Everyone', icon: const Icon(Icons.person_outline), backgroundColor: Colors.blue),
  Audience(title: 'Followers', subTitle: '6500 user', icon: const Icon(Icons.star, color: Colors.white), backgroundColor: Colors.greenAccent),
  Audience(title: 'Registered Users', subTitle: '3300 user', icon: const Icon(Icons.wine_bar), backgroundColor: Colors.yellow),
  Audience(title: 'Loyalty Member', subTitle: '600 user', icon: const Icon(Icons.favorite), backgroundColor: Colors.redAccent),
];

List<TextAlign> textAligns = [
  TextAlign.center,
  TextAlign.justify,
  TextAlign.left,
  TextAlign.right,
];

const fontFamilies = [
  'Alegreya',
  'B612',
  'TitilliumWeb',
  'Varela',
  'Vollkorn',
  'Rakkas',
  'ConcertOne',
  'YatraOne',
  'OldStandardTT',
  'Neonderthaw',
  'DancingScript',
  'SedgwickAve',
  'IndieFlower',
  'Sacramento',
  'PressStart2P',
  'FrederickatheGreat',
  'ReenieBeanie',
  'BungeeShade',
  'UnifrakturMaguntia',
];

var buttonShapesIcons = [
  'assets/icons/button_shape_sharp_edges.svg',
  'assets/icons/button_shape_round_edges.svg',
  'assets/icons/button_shape_round.svg',
  'assets/icons/button_shape_message.svg',
];

typedef IndexCallback = void Function(int index);

List<MaterialColor> materialColors = <MaterialColor>[
  MaterialColor(Colors.black.value, {50: Colors.black.withOpacity(0.05), 100: Colors.black.withOpacity(0.1)}),
  MaterialColor(Colors.transparent.value, const {}),
  MaterialColor(Colors.white.value, {50: Colors.white.withOpacity(0.05), 100: Colors.white.withOpacity(0.1)}),
  ...Colors.primaries.map((e) => e),
  ...Colors.accents.map(
    (e) => MaterialColor(e.value, const {}),
  )
];

class CColors extends StatelessWidget {
  const CColors({super.key, required this.index, required this.selectedColorIndex});
  final IndexCallback index;
  final int selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, currentIndex) => GestureDetector(
              onTap: () => index(currentIndex),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 30,
                decoration: BoxDecoration(
                  color: materialColors[currentIndex],
                  border: currentIndex == 1 ? Border.all(color: Colors.white) : null,
                  boxShadow: currentIndex == 1
                      ? null
                      : [
                          const BoxShadow(
                            spreadRadius: 2.5,
                            color: Colors.white,
                          ),
                          const BoxShadow(
                            spreadRadius: 1.5,
                            color: Colors.black,
                          ),
                        ],
                  shape: BoxShape.circle,
                ),
                child: selectedColorIndex == currentIndex ? const Center(child: Icon(Icons.check, color: Colors.white)) : null,
              ),
            ),
            itemCount: materialColors.length,
          ),
        ),
      ),
    );
  }
}

class CFonts extends StatelessWidget {
  const CFonts({super.key, required this.index, required this.selectedFontIndex});
  final IndexCallback index;
  final int selectedFontIndex;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: fontFamilies.length,
          itemBuilder: (context, currentIndex) => Padding(
            // padding: const EdgeInsets.all(horizontal: 8),
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () => index(currentIndex),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: selectedFontIndex == currentIndex ? 2 : 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    fontFamilies[currentIndex],
                    style: TextStyle(
                      fontWeight: selectedFontIndex == currentIndex ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CButtonShape extends StatelessWidget {
  const CButtonShape({super.key, required this.index, required this.selectedShapeIndex, required this.color});
  final IndexCallback index;
  final int selectedShapeIndex;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: buttonShapesIcons.length,
          itemBuilder: (context, currentIndex) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            child: Center(
              child: GestureDetector(
                onTap: () => index(currentIndex),
                child: SvgPicture.asset(
                  buttonShapesIcons[currentIndex],
                  height: 40,
                  colorFilter: ColorFilter.mode(currentIndex == selectedShapeIndex ? color : Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CButton extends StatefulWidget {
  const CButton({
    super.key,
    required this.selectedShapeIndex,
    required this.color,
    required this.fontFamily,
    required this.buttonText,
    required this.fontSize,
    this.enabled = true,
    this.onChange,
    required this.controller,
  });
  final int selectedShapeIndex;
  final Color color;
  final String fontFamily;
  final String buttonText;
  final double fontSize;
  final bool enabled;
  final ValueChanged<String>? onChange;
  final TextEditingController controller;

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedShapeIndex == 3
        ? Center(
            child: ClipPath(
              clipper: ButtonMessageShape(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: widget.color,
                ),
                child: TextField(
                  autofocus: true,
                  enabled: widget.enabled,
                  textAlign: TextAlign.center,
                  controller: controller,
                  onChanged: widget.onChange,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: widget.fontSize,
                        fontFamily: widget.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                  cursorColor: Colors.white,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      bottom: widget.fontSize > 28 && widget.fontSize < 40
                          ? screenSize.height * 0.04
                          : widget.fontSize > 40
                              ? screenSize.height * 0.1
                              : screenSize.height * 0.015,
                    ),
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
            width: buttonWidth,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(
                widget.selectedShapeIndex == 0
                    ? 0
                    : widget.selectedShapeIndex == 1
                        ? 8
                        : 999,
              ),
            ),
            child: TextField(
              autofocus: true,
              enabled: widget.enabled,
              controller: controller,
              onChanged: widget.onChange,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: widget.fontSize,
                    fontFamily: widget.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
              cursorColor: Colors.white,
              maxLines: null,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          );
  }
}

class ButtonMessageShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    double depth = size.height * 0.7;

    path.moveTo(0, size.height * 0.1);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.04, depth);
    path.lineTo(size.width * 0.97, depth);
    path.quadraticBezierTo(size.width, depth, size.width, depth * 0.8);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(size.width, 0, size.width * 0.97, 0);
    path.lineTo(size.width * 0.03, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.1);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kToolbarHeight),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          width: screenSize.width * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff141414),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xff58575A))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: product.productType == ProductType.product
                      ? Image.asset(
                          product.image!,
                          fit: BoxFit.fill,
                          height: 45,
                          width: 45,
                        )
                      : SvgPicture.asset(
                          'assets/images/Location.svg',
                          fit: BoxFit.fill,
                          height: 45,
                          width: 45,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        product.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        product.subTitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xffBCBCBC), fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget verticalSlider(double fontSize, ValueChanged onChange) {
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
        onChanged: onChange,
      ),
    ),
  );
}

Size calculateTextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size;
}
