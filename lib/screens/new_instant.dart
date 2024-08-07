import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/screens/audiance_screen.dart';
import 'package:screens/screens/sudio_main.dart';
import 'package:screens/utils/constants.dart';

import '../model/editing_item.dart';

class NewInstantScreen extends StatefulWidget {
  const NewInstantScreen({super.key, required this.imageFile, required this.items, this.backgroundImage, this.backgroundColor, this.backgroundVideoFile});
  final File imageFile;
  final File? backgroundImage;
  final Color? backgroundColor;
  final File? backgroundVideoFile;
  final List<EditItem>? items;

  @override
  State<NewInstantScreen> createState() => _NewInstantScreenState();
}

class _NewInstantScreenState extends State<NewInstantScreen> {
  int selectedAudienceIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F8),
      appBar: AppBar(
        title: Text(
          'New Instant Page.',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff58575A)),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xff58575A),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              imageCard(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  onTap: () async {
                    await showModalBottomSheet(context: context, builder: (builder) => AudienceScreen(selectedIndex: selectedAudienceIndex)).then((returnValue) {
                      if (returnValue != null) {
                        setState(() {
                          selectedAudienceIndex = returnValue;
                        });
                      }
                    });
                  },
                  tileColor: Colors.white,
                  title: Text(
                    'Who can see this ?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff58575A)),
                  ),
                  leading: const Icon(
                    Icons.lock,
                    color: Color(0xff58575A),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(audiences[selectedAudienceIndex].title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffBCBCBC))),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Color(0xff58575A),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
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
                                    'assets/icons/done_bg.svg',
                                    height: 110,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Instant Page is Published.',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Your Instant Page is Published.',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color(0xff0CC67C)),
                                  ),
                                  const SizedBox(height: 30),
                                  Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: const WidgetStatePropertyAll(Color(0xFF0CC67C)),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StudioMain(
                                                      imageFile: widget.imageFile,
                                                      items: widget.items,
                                                      backgroundColor: widget.backgroundColor,
                                                      backgroundImage: widget.backgroundImage,
                                                      backgroundVideoFile: widget.backgroundVideoFile,
                                                    )));
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
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: screenSize.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff27262A),
                        ),
                        child: Center(
                          child: Text(
                            'Publish',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imageCard() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: screenSize.height * 0.6,
        width: screenSize.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              offset: Offset(6, 6),
            )
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                widget.imageFile,
                fit: BoxFit.fill,
                height: screenSize.height * 0.6,
                width: screenSize.width * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xff27262A).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Preview',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
