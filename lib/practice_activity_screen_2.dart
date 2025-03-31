import 'package:eng_app_2/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/unit_data.dart';

class PracticeActivityScreen2 extends StatefulWidget {
  final int unitIndex;
  PracticeActivityScreen2({required this.unitIndex});

  @override
  _PracticeActivityScreen2State createState() => _PracticeActivityScreen2State();
}

class _PracticeActivityScreen2State extends State<PracticeActivityScreen2> {
  FlutterTts flutterTts = FlutterTts();
  late YoutubePlayerController _controller;
  bool isVideoReady = false;

  @override
  void initState() {
    super.initState();
    _speakText();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(units[widget.unitIndex].practiceVideoUrl)!,
      flags: YoutubePlayerFlags(autoPlay: false),
    );
  }

  void _speakText() async {
    await flutterTts.speak(units[widget.unitIndex].practiceActivityDescription2);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Activity 2"),
        backgroundColor: Color(0xFF010066),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              unit.practiceActivityDescription2,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            Center(
              child: isVideoReady
                  ? YoutubePlayer(controller: _controller)
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6100)),
                onPressed: () {
                  setState(() {
                    isVideoReady = true;
                  });
                },
                child: Text("Play Video", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6100)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(unitIndex: widget.unitIndex),
                    ),
                  );
                },
                child: Text("Next: Quiz", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}