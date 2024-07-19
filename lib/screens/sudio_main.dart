import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/screens/imagesscreen.dart';
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
  bool showMenu = false;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showMenu = false;
              });
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.file(
                widget.imageFile,
                height: screenSize.height * 0.9,
                width: screenSize.width,
              ),
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
                    child: showMenu
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                  showDialog(
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
                                                  'assets/icons/pin_bg.svg',
                                                  height: 110,
                                                  fit: BoxFit.fill,
                                                ),
                                                const SizedBox(height: 30),
                                                Text(
                                                  'Pin this as Main Page.',
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Do you want to set this as main page?',
                                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color(0xFF622CEA)),
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
                                                            side: const BorderSide(color: Color(0xFF622CEA)),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudioMain(imageFile: widget.imageFile, items: widget.items)));
                                                      },
                                                      child: const Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 12),
                                                          child: Text(
                                                            'Confirm',
                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF622CEA)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor: const WidgetStatePropertyAll(Color(0xFF622CEA)),
                                                        shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 12),
                                                          child: Text(
                                                            'Confirm',
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
                                  ).whenComplete(
                                    () => setState(() {
                                      selectedIndex = null;
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: selectedIndex == 0 ? const Color(0xffF03B77) : const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/pin.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                  showDialog(
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
                                                  'assets/icons/un_publish_bg.svg',
                                                  height: 110,
                                                  fit: BoxFit.fill,
                                                ),
                                                const SizedBox(height: 30),
                                                Text(
                                                  'Unpublish the Instant Page?',
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Your instant page will be saved in Draft.',
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
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 12),
                                                          child: Text(
                                                            'Confirm',
                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFFE2B54)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor: const WidgetStatePropertyAll(Color(0xFFFE2B54)),
                                                        shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 12),
                                                          child: Text(
                                                            'Confirm',
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
                                  ).whenComplete(
                                    () => setState(() {
                                      selectedIndex = null;
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: selectedIndex == 1 ? const Color(0xffF03B77) : const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/publish.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/edit.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 3;
                                  });
                                  showDialog(
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
                                                      onPressed: () async {
                                                        Navigator.pop(context);
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
                                                      onPressed: () async {
                                                        Navigator.pop(context);
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
                                  ).whenComplete(
                                    () => setState(() {
                                      selectedIndex = null;
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: selectedIndex == 3 ? const Color(0xffF03B77) : const Color(0xff27262A).withOpacity(0.85), shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/trash.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagesScreen()));
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
                                  setState(() {
                                    showMenu = true;
                                  });
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
              child: Center(
                child: Text(
                  'Preview',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Draft',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
