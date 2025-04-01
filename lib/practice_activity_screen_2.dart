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
  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _speakText();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(units[widget.unitIndex].practiceVideoUrl)!,
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
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
        title: Text("Practice Activity 2", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF010066),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Description
            Text(
              unit.practiceActivityDescription2,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),

            // YouTube Video (Displayed but plays only on click)
            Center(
              child: isVideoPlaying
                  ? YoutubePlayer(controller: _controller)
                  : GestureDetector(
                onTap: () {
                  setState(() {
                    isVideoPlaying = true;
                    _controller.play();
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("https://img.youtube.com/vi/${_controller.initialVideoId}/0.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Next Button (Blue)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF010066),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(unitIndex: widget.unitIndex),
                    ),
                  );
                },
                child: Text("Next: Quiz", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
