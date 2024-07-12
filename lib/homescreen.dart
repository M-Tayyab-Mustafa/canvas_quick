import 'package:flutter/material.dart';
import 'package:screens/itemscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemSCreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(6.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade800,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: const Text(
                          "To find nearby place, Please turn on location services.",
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .21,
                        height: MediaQuery.of(context).size.height * .045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.pink,
                        ),
                        child: const Center(
                          child: Text(
                            "Turn On",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Custom TabBar
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabSelected(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'For You',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        if (_selectedTabIndex == 0)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 2,
                            width: 130,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabSelected(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Browse',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        if (_selectedTabIndex == 1)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 2,
                            width: 130,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Tab Content
            Expanded(
              child: _selectedTabIndex == 0
                  ? const SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Kuala Lumpur City Centre",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Kuala Lumpur, 5000, Malasia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Pavilion Kuala Lumpur",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Kuala Lumpur, 5000, Malasia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Mid Valley Megamall",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "KBander Utama , PEtaling jaya,47800,Malaysia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Publika",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Solaris Dutamas, Kuala Lumpr,50000,Malaysia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "TRX Shopping Gallary",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "TRX,Kuala Lumpur 50000, Malaysia  ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "IKEA Ikano Power Centre",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Mutiara Damansora,Petaling jaya, 47000,Malaysia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Jalan Alor ",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Kuala Lumpur, 5000, Malasia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Kuala Lumpur City Centre",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Kuala Lumpur 50000, Malaysia ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Browse data',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black, items: const [
        BottomNavigationBarItem(
            label: '.',
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: "abc",
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: "gj",
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ))
      ]),
    );
  }
}
