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
        title: Text("Practice Activity"),
        backgroundColor: Color(0xFF010066),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              unit.practiceActivityDescription1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6100),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: () {
                // Implement file upload functionality here
              },
              child: Text("Upload Answers", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6100),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: () {
                // Implement file upload functionality here
              },
              child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF010066),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
          ],
        ),
      ),
    );
  }
}
