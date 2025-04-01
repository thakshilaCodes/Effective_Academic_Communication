import 'package:flutter/material.dart';
import '../models/unit_data.dart';
import 'homescreen.dart';
import 'summary_screen.dart';

class InClassActivityScreen extends StatefulWidget {
  final int unitIndex;
  InClassActivityScreen({required this.unitIndex});

  @override
  _InClassActivityScreenState createState() => _InClassActivityScreenState();
}

class _InClassActivityScreenState extends State<InClassActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("In-Class Activity", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
        backgroundColor: Color(0xFF010066), // AppBar color
        centerTitle: true,

      ),
      body: Container(
        color: Colors.white, // Background color of the screen
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // In-class activity instructions
            Text(
              unit.inClassActivity,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Finish button to complete unit and redirect to home screen
            ElevatedButton(
              onPressed: () {
                // Mark unit 1 as completed and unlock unit 2
                // You can implement this logic by updating a progress tracker or state
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(username: ''), // Redirect to home screen after finish
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6100), // Button color
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
              ),
              child: Text(
                "Finish",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
