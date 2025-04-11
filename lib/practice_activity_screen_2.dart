import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/quiz_screen.dart';

class PracticeActivityScreen2 extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const PracticeActivityScreen2({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  State<PracticeActivityScreen2> createState() => _PracticeActivityScreen2State();
}

class _PracticeActivityScreen2State extends State<PracticeActivityScreen2> {
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (widget.unitData != null &&
        widget.unitData!.practiceVideoUrl != null &&
        widget.unitData!.practiceVideoUrl!.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(widget.unitData!.practiceVideoUrl!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch URL: $url"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.unitData;
    final hasVideo =
        unit?.practiceVideoUrl != null && unit!.practiceVideoUrl!.isNotEmpty;
    final hasLink =
        unit?.practiceActivityLink2 != null && unit!.practiceActivityLink2!.isNotEmpty;
    final hasUploadLink =
        unit?.practiceUploadLink2 != null && unit!.practiceUploadLink2!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subunitTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF010066),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: unit == null || (unit.practiceActivityDescription2.isEmpty && !hasVideo)
          ? const Center(
        child: Text(
          "No practice activity 2 available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show description
            if (unit.practiceActivityDescription2.isNotEmpty)
              Text(
                unit.practiceActivityDescription2,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10),

            // Show video if available
            if (hasVideo && _youtubeController != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.red,
                    handleColor: Colors.redAccent,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Show task link button
            if (hasLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => _launchURL(unit.practiceActivityLink2!),
                child: const Text("Go to Task Site",
                    style: TextStyle(color: Colors.white)),
              ),

            // Show upload button
            if (hasUploadLink)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => _launchURL(unit.practiceUploadLink2!),
                  child: const Text("Upload Your Answer",
                      style: TextStyle(color: Colors.white)),
                ),
              ),

            const SizedBox(height: 20),

            // Go to Quiz button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6100),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      unitIndex: widget.unitIndex,
                      subunitIndex: widget.subunitIndex,
                      subunitTitle: widget.subunitTitle,
                      unitData: widget.unitData,
                    ),
                  ),
                );
              },
              child: const Text("Go to Quiz",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}