

import 'package:flutter/material.dart';
import 'package:screens/imagesscreen.dart';
class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey.shade800,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.black,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search Location',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImagesScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          SizedBox(height: 35,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: MediaQuery.of(context).size.width * .28,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.alternate_email_outlined,color: Colors.red,),
                Text("Product"
                )
              ],),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.home_repair_service,color: Colors.green,),
                Text("Service",)
              ],),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.headset_mic_rounded,color: Colors.blue,),
                Text("Chat")
              ],),
            )
          ],),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_rounded,color: Colors.red,),
                    Text("Location"
                    )
                  ],),
              ),
              SizedBox(width:  MediaQuery.of(context).size.height * .01,),

              Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home,color: Colors.redAccent,),
                    Text("Show Only")
                  ],),
              )
            ],),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .28,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sticky_note_2_rounded,color: Colors.deepPurple,),
                    Text("Tickets"
                    )
                  ],),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image,color: Colors.green,),
                    Text("Image",)
                  ],),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image,color: Colors.blue,),
                    Text("Frame")
                  ],),
              )
            ],),

        ],),
      ),
    );
  }
}
