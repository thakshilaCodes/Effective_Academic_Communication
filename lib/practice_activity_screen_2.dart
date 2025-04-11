import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/all_units.dart';
import 'models/unit_model.dart';
import 'quiz_screen.dart';

class PracticeActivityScreen2 extends StatefulWidget {
  final int unitIndex;
  const PracticeActivityScreen2({required this.unitIndex});

  @override
  State<PracticeActivityScreen2> createState() => _PracticeActivityScreen2State();
}

class _PracticeActivityScreen2State extends State<PracticeActivityScreen2> {
  late UnitModel unit;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    unit = units[widget.unitIndex];

    if (unit.practiceVideoUrl!= null) {
      final videoId = YoutubePlayer.convertUrlToId(unit.practiceVideoUrl!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasVideo = unit.practiceVideoUrl != null;
    final hasLink = unit.practiceActivityLink2 != null;
    final hasUploadLink = unit.practiceUploadLink2 != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Activity 2", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF010066),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show description
            Text(
              unit.practiceActivityDescription2,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Show video if available
            if (hasVideo && _youtubeController != null)
              YoutubePlayer(controller: _youtubeController!),

            const SizedBox(height: 20),

            // Show task link button
            if (hasLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => _launchURL(unit.practiceActivityLink2!),
                child: const Text("Go to Task Site", style: TextStyle(color: Colors.white)),
              ),

            // Show upload button
            if (hasUploadLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _launchURL(unit.practiceUploadLink2!),
                child: const Text("Upload Your Answer", style: TextStyle(color: Colors.white)),
              ),

            const Spacer(),

            // Go to Quiz button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF010066)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen(unitIndex: widget.unitIndex)),
                );
              },
              child: const Text("Go to Quiz", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
