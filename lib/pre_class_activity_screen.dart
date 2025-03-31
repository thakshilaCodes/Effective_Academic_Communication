import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/unit_data.dart';
import 'instructions_screen.dart';

class PreClassActivityScreen extends StatefulWidget {
  final int unitIndex;
  PreClassActivityScreen({required this.unitIndex});

  @override
  _PreClassActivityScreenState createState() => _PreClassActivityScreenState();
}

class _PreClassActivityScreenState extends State<PreClassActivityScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakDescription();
  }

  void _speakDescription() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(units[widget.unitIndex].preClassActivityDescription);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-Class Activity"),
        backgroundColor: Color(0xFF010066),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description with TTS
            Text(
              "Instructions:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010066),
              ),
            ),
            SizedBox(height: 10),
            Text(
              unit.preClassActivityDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade400),

            // Task Display
            Text(
              "Your Task:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010066),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unit.preClassActivity,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6100),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // Upload action here
                  },
                  child: Text("Upload Answers", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF010066),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InstructionsScreen(unitIndex: widget.unitIndex),
                      ),
                    );
                  },
                  child: Text("Next: Instructions", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}