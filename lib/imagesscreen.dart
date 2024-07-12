import 'package:flutter/material.dart';

import 'audiancescreen.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  final List<String> images = [
    "assets/images/image1.jpeg",
    "assets/images/image2.jpeg",
    "assets/images/image3.jpeg",
    "assets/images/image4.jpeg",
    "assets/images/image5.jpeg",
    "assets/images/image6.jpeg",
    "assets/images/image7.jpeg",
    "assets/images/image8.jpeg",
    "assets/images/image9.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .09,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .24,
                  height: MediaQuery.of(context).size.height * .1,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .06,
                        height: MediaQuery.of(context).size.height * .03,
                        color: Colors.white,
                      ),
                      Text(
                        "Solid",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .24,
                  height: MediaQuery.of(context).size.height * .1,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      Text(
                        "Image",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .24,
                  height: MediaQuery.of(context).size.height * .1,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ondemand_video_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        "Video",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AudienceScreen()));
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.56,
                children: List.generate(images.length, (index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          images[index],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
