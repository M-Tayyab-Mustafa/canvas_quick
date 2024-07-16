import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/model/product.dart';

import '../model/audience.dart';
import '../model/editing_item.dart';

late Size screenSize;

enum EditItemType { button, text, other }

enum ProductType { product, location }

const fontFamilies = [
  'OpenSans',
  'Billabong',
  'GrandHotel',
  'Oswald',
  'Quicksand',
  'BeautifulPeople',
  'BeautyMountains',
  'BiteChocolate',
  'BlackberryJam',
  'BunchBlossoms',
  'CinderelaRegular',
  'Countryside',
  'Halimun',
  'LemonJelly',
  'QuiteMagicalRegular',
  'Tomatoes',
  'TropicalAsianDemoRegular',
  'VeganStyle',
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
  'UnifrakturMaguntia'
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
  ...Colors.primaries.map((e) => e)
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
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 2.5,
                      color: Colors.white,
                    ),
                    BoxShadow(
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

class CButton extends StatelessWidget {
  const CButton({super.key, required this.selectedShapeIndex, required this.color, required this.fontFamily});
  final int selectedShapeIndex;
  final Color color;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return selectedShapeIndex == 3
        ? Center(
            child: ClipPath(
              clipper: ButtonMessageShape(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
                height: 65,
                width: screenSize.width * 0.8,
                decoration: BoxDecoration(
                  color: color,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenSize.height * 0.022),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Get Your Box Today!', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                      const SizedBox(width: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: VerticalDivider(width: 2, thickness: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
              height: 45,
              width: screenSize.width * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  selectedShapeIndex == 0
                      ? 0
                      : selectedShapeIndex == 1
                          ? 8
                          : 999,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text('Get Your Box Today!', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 10),
                    const VerticalDivider(width: 2, thickness: 2, color: Colors.white),
                  ],
                ),
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

class EditItems extends StatefulWidget {
  const EditItems({super.key, required this.items, this.fromTemplateScreen = false});
  final List<EditItem> items;
  final bool fromTemplateScreen;

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.items
          .map(
            (item) => Positioned(
              top: widget.fromTemplateScreen
                  ? item.position.dy > screenSize.height / 2
                      ? item.position.dy - screenSize.height * 0.263
                      : item.position.dy
                  : item.position.dy,
              left: widget.fromTemplateScreen ? item.position.dx - screenSize.width * 0.06 : item.position.dx,
              child: item.type == EditItemType.text
                  ? Draggable(
                      feedback: ItemTextWidget(item: item),
                      childWhenDragging: const Text(''),
                      onDragEnd: (details) {
                        setState(() {
                          item.position = details.offset;
                        });
                      },
                      child: ItemTextWidget(item: item),
                    )
                  : Draggable(
                      feedback: CButton(color: item.color!, fontFamily: item.fontFamily!, selectedShapeIndex: item.selectedButtonShapeIndex!),
                      childWhenDragging: const Text(''),
                      onDragEnd: (details) {
                        setState(() {
                          item.position = details.offset;
                        });
                      },
                      child: CButton(color: item.color!, fontFamily: item.fontFamily!, selectedShapeIndex: item.selectedButtonShapeIndex!),
                    ),
            ),
          )
          .toList(),
    );
  }
}

class ItemTextWidget extends StatelessWidget {
  const ItemTextWidget({super.key, required this.item});
  final EditItem item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: item.text!.length * item.fontSize! > screenSize.width ? screenSize.width * 0.7 : null,
      child: Text(
        item.text!,
        textAlign: item.textAlign,
        softWrap: true,
        style: TextStyle(
          fontSize: item.fontSize,
          color: item.color,
          fontFamily: item.fontFamily,
        ),
      ),
    );
  }
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

List<Audience> audiences = [
  Audience(title: 'Public', subTitle: 'Open To Everyone', icon: const Icon(Icons.person_outline), backgroundColor: Colors.blue),
  Audience(title: 'Followers', subTitle: '6500 user', icon: const Icon(Icons.star, color: Colors.white), backgroundColor: Colors.greenAccent),
  Audience(title: 'Registered Users', subTitle: '3300 user', icon: const Icon(Icons.wine_bar), backgroundColor: Colors.yellow),
  Audience(title: 'Loyalty Member', subTitle: '600 user', icon: const Icon(Icons.favorite), backgroundColor: Colors.redAccent),
];
