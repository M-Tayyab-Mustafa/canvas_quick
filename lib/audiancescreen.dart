import 'package:flutter/material.dart';
class AudienceScreen extends StatefulWidget {
  const AudienceScreen({super.key});

  @override
  State<AudienceScreen> createState() => _AudienceScreenState();
}

class _AudienceScreenState extends State<AudienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
        SizedBox(height: MediaQuery.of(context).size.height*.06,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(children: [
            Icon(Icons.clear,),
            SizedBox(width:MediaQuery.of(context).size.width*.04 ,),
            Text("Audience",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
          ],),
        ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
              child: Column(children: [
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person_outline),backgroundColor: Colors.blue,),
                  title: Text("Public"),
                  subtitle: Text("Open To Everyone",style: TextStyle(color: Colors.grey),),
                  trailing: Icon(Icons.circle_outlined,color: Colors.purple,),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.star,color: Colors.white,),backgroundColor: Colors.greenAccent,),
                  title: Text("Followers"),
                  subtitle: Text("6500 user",style: TextStyle(color: Colors.grey),),
                  trailing: Icon(Icons.check_box_outline_blank),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.wine_bar,),backgroundColor: Colors.yellow,),
                  title: Text("Registered Users"),
                  subtitle: Text("3300 user",style: TextStyle(color: Colors.grey),),
                  trailing: Icon(Icons.check_box_outline_blank),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.favorite,color: Colors.white,),backgroundColor: Colors.redAccent,),
                  title: Text("Loyalty Member"),
                  subtitle: Text("600 user",style: TextStyle(color: Colors.grey),),
                  trailing: Icon(Icons.check_box_outline_blank),
                )
              ],),
            )

            ],),
      ),);
  }
}
