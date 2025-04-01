import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/unit_data.dart';
import 'pre_class_activity_screen.dart';

class IntroductionScreen extends StatefulWidget {
  final int unitIndex;
  IntroductionScreen({required this.unitIndex});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakText();
  }

  void _speakText() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(units[widget.unitIndex].introductionText);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(unit.unitName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
        backgroundColor: Color(0xFF010066),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Introduction",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF010066),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      unit.introductionText,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6100),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreClassActivityScreen(unitIndex: widget.unitIndex),
                    ),
                  );
                },
                child: Text(
                  "Next: Pre-Class Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}