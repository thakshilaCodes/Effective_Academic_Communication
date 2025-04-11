import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode;

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/all_units.dart';
import 'models/unit_model.dart';
import 'practice_activity_screen_2.dart';

class PracticeActivityScreen extends StatefulWidget {
  final int unitIndex;
  const PracticeActivityScreen({required this.unitIndex});

  @override
  _PracticeActivityScreenState createState() => _PracticeActivityScreenState();
}

class _PracticeActivityScreenState extends State<PracticeActivityScreen> {
  late UnitModel unit;
  List<TextEditingController> controllers = [];
  bool isSubmitted = false;
  bool allAnswered = false;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    unit = units[widget.unitIndex];

    if (unit.practiceActivityQuestions1 != null) {
      controllers = List.generate(unit.practiceActivityQuestions1!.length, (_) => TextEditingController());
    }

    if (unit.practiceActivityVideo != null) {
      final videoId = YoutubePlayer.convertUrlToId(unit.practiceActivityVideo!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    }
  }

  void validateAnswers() {
    setState(() {
      allAnswered = controllers.every((controller) => controller.text.trim().isNotEmpty);
      if (!allAnswered) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please answer all questions!"), backgroundColor: Colors.red),
        );
      } else {
        isSubmitted = true;
      }
    });
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
    for (var controller in controllers) {
      controller.dispose();
    }
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasLink = unit.practiceActivityLink != null;
    final hasUploadLink = unit.practiceUploadLink != null;
    final hasVideo = unit.practiceActivityVideo != null;
    final hasQuestions = unit.practiceActivityQuestions1 != null && unit.practiceActivityQuestions1!.isNotEmpty;

    final canProceed = hasQuestions ? isSubmitted : true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Activity", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF010066),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(unit.practiceActivityDescription1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            if (hasLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => _launchURL(unit.practiceActivityLink!),
                child: const Text("Go to Task Site", style: TextStyle(color: Colors.white)),
              ),

            if (hasLink && hasUploadLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _launchURL(unit.practiceUploadLink!),
                child: const Text("Upload Your Answer", style: TextStyle(color: Colors.white)),
              ),

            if (hasVideo && _youtubeController != null)
              YoutubePlayer(controller: _youtubeController!),

            if (hasQuestions)
              Expanded(
                child: ListView.builder(
                  itemCount: unit.practiceActivityQuestions1!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(unit.practiceActivityQuestions1![index].questionText, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              hintText: "Type your answer...",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            if (hasQuestions && !isSubmitted)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: validateAnswers,
                child: const Text("Submit", style: TextStyle(color: Colors.white)),
              ),

            if (canProceed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF010066)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeActivityScreen2(unitIndex: widget.unitIndex)),
                  );
                },
                child: const Text("Next: Practice Activity 2", style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}