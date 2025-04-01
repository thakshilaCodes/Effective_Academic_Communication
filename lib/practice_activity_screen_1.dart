import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'practice_activity_screen_2.dart';
import '../models/unit_data.dart';

class PracticeActivityScreen extends StatefulWidget {
  final int unitIndex;
  PracticeActivityScreen({required this.unitIndex});

  @override
  _PracticeActivityScreenState createState() => _PracticeActivityScreenState();
}

class _PracticeActivityScreenState extends State<PracticeActivityScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakText();
  }

  void _speakText() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(units[widget.unitIndex].practiceActivityDescription1);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Activity", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF010066),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Description
            Text(
              unit.practiceActivityDescription1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Activity Content
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF010066), width: 2),
              ),
              child: Text(
                unit.practiceActivity,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            Spacer(), // Pushes the buttons to the bottom

            // Buttons at the Bottom
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Upload Answers Button (Linked to practiceUploadLink)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6100),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Open the upload link using Navigator (Assuming it's a route)
                    Navigator.pushNamed(context, unit.practiceUploadLink);
                  },
                  child: Text("Upload Answers", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(height: 10),

                // Next Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF010066),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PracticeActivityScreen2(unitIndex: widget.unitIndex),
                      ),
                    );
                  },
                  child: Text("Next: Practice Activity 2", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(height: 20), // Extra spacing at the bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}
