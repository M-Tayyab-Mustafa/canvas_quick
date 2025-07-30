import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../images_screen.dart';

class InstantScreen extends StatelessWidget {
  const InstantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          // Align(
          //   alignment: const Alignment(-0.9, -0.9),
          //   child: GestureDetector(
          //     onTap: () => Navigator.pop(context),
          //     child: const Icon(
          //       Icons.cancel_rounded,
          //       size: 40,
          //     ),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'No Instant page yet.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Try building your first instant pages.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagesScreen()));
                  },
                  child: const Text(
                    'Add New Instant Page',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
