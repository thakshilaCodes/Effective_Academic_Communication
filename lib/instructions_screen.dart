import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'practice_activity_screen_1.dart';
import 'models/unit_data.dart';

class InstructionsScreen extends StatefulWidget {
  final int unitIndex;
  InstructionsScreen({required this.unitIndex});

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  FlutterTts flutterTts = FlutterTts();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _speakText();
    _controller = YoutubePlayerController(
      initialVideoId: units[widget.unitIndex].instructionVideoId,
      flags: YoutubePlayerFlags(autoPlay: false),
    );
  }

  void _speakText() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(units[widget.unitIndex].instructionsText);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF010066),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions Text
            Text(
              unit.instructionsText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            SizedBox(height: 20),

            // YouTube Video Player
            YoutubePlayer(controller: _controller),

            Spacer(),

            // Next Button at the Bottom Center
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PracticeActivityScreen(unitIndex: widget.unitIndex),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF010066),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Next: Practice Activity", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20), // Add space below button
          ],
        ),
      ),
    );
  }
}
