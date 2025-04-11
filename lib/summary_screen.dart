import 'package:flutter/material.dart';
import 'models/all_units.dart';
import 'models/unit_data/unit_01_00.dart';
import 'in_class_activity_screen.dart'; // Import the InClassActivityScreen
import 'package:flutter_tts/flutter_tts.dart'; // Import text-to-speech package

class SummaryScreen extends StatelessWidget {
  final int unitIndex;
  SummaryScreen({required this.unitIndex});

  final FlutterTts _flutterTts = FlutterTts(); // Initialize text-to-speech

  // Function to speak the summary text
  Future<void> _speakSummary(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson Summary", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
        backgroundColor: Color(0xFF010066), // Color for app bar
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white, // Set background to white
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary text
            Text(
              unit.summary,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Button to activate text-to-speech for summary
            ElevatedButton(
              onPressed: () => _speakSummary(unit.summary),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6100), // Button color
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
              ),
              child: Text(
                "Listen to Summary",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // "Next" button to go to the InClassActivityScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InClassActivityScreen(unitIndex: unitIndex),
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
                "Next",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
