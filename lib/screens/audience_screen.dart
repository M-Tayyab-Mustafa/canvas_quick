import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AudienceScreen extends StatefulWidget {
  const AudienceScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<AudienceScreen> createState() => _AudienceScreenState();
}

class _AudienceScreenState extends State<AudienceScreen> {
  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.5,
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * .01,
                ),
                SizedBox(
                  width: screenSize.width * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const Divider(
                      height: 3,
                      thickness: 3,
                      color: Color(0xff58575A),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.clear,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * .04,
                      ),
                      const Text(
                        "Audience",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: audiences.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => Navigator.pop(context, index),
                      leading: CircleAvatar(
                        backgroundColor: audiences[index].backgroundColor,
                        child: audiences[index].icon,
                      ),
                      title: Text(audiences[index].title),
                      subtitle: Text(
                        audiences[index].subTitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: selectedIndex == index ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
