import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screens/tagsscreen.dart';

class ItemSCreen extends StatefulWidget {
  const ItemSCreen({super.key});

  @override
  State<ItemSCreen> createState() => _ItemSCreenState();
}

class _ItemSCreenState extends State<ItemSCreen> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TagScreen()));
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
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("For You", style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text("See More", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/box1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Mail Box", style: TextStyle(color: Colors.white),),
                    subtitle: Text("MB-203998A", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/22.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Regular Sloted Corten", style: TextStyle(color: Colors.white),),
                    subtitle: Text("RSC-6009-4A", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/33.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Top Bottom Storage Box", style: TextStyle(color: Colors.white),),
                    subtitle: Text("TBSB-8900-2C", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/44.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Paper Sheets", style: TextStyle(color: Colors.white),),
                    subtitle: Text("PS-356688", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/55.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Archive Box", style: TextStyle(color: Colors.white),),
                    subtitle: Text("Ab-66534-NP", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/66.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("OFFset Printing Box", style: TextStyle(color: Colors.white),),
                    subtitle: Text("OFP-67800-4C", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/77.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Full Color Printing Box", style: TextStyle(color: Colors.white),),
                    subtitle: Text("FCPB-8800998-3C", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
