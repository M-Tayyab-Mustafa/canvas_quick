import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screens/screens/audiance_screen.dart';
import 'package:screens/utils/constants.dart';

class NewInstantScreen extends StatefulWidget {
  const NewInstantScreen({super.key, required this.imageFile});
  final File imageFile;

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
                    // Todo implement Functionality
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
