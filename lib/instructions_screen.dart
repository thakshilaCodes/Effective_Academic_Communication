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
  bool _isVideoInitialized = false;

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

  void _playVideo() {
    setState(() {
      _isVideoInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Instructions"),
        backgroundColor: Color(0xFF010066),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.instructionsText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              SizedBox(height: 20),

              _isVideoInitialized
                  ? YoutubePlayer(controller: _controller)
                  : ElevatedButton(
                onPressed: _playVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6100),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Play Video", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),

              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Next: Practice Activity", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
