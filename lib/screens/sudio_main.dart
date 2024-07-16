import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/screens/new_instant.dart';
import 'package:screens/utils/constants.dart';

import '../model/editing_item.dart';

class StudioMain extends StatefulWidget {
  const StudioMain({super.key, required this.imageFile, required this.items});
  final File imageFile;
  final List<EditItem> items;

  @override
  State<StudioMain> createState() => _StudioMainState();
}

class _StudioMainState extends State<StudioMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.file(
              widget.imageFile,
              height: screenSize.height * 0.9,
              width: screenSize.width,
            ),
          ),
          topMenu(),
          bottomMenu()
        ],
      ),
    );
  }

  Widget topMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: kToolbarHeight,
          child: Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/cancel.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement functionality
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement functionality
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomMenu() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: screenSize.height * 0.1,
        width: screenSize.width,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewInstantScreen(imageFile: widget.imageFile)));
                },
                child: Center(
                  child: Text(
                    'Preview',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //
                },
                child: Center(
                  child: Text(
                    'Draft',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
