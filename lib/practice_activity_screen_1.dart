import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/practice_activity_screen_2.dart';

class PracticeActivityScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const PracticeActivityScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  _PracticeActivityScreenState createState() => _PracticeActivityScreenState();
}

class _PracticeActivityScreenState extends State<PracticeActivityScreen> {
  List<TextEditingController> controllers = [];
  bool isSubmitted = false;
  bool allAnswered = false;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (widget.unitData != null) {
      if (widget.unitData!.practiceActivityQuestions1 != null) {
        controllers = List.generate(
          widget.unitData!.practiceActivityQuestions1!.length,
              (_) => TextEditingController(),
        );
      }

      if (widget.unitData!.practiceActivityVideo != null &&
          widget.unitData!.practiceActivityVideo!.isNotEmpty) {
        final videoId = YoutubePlayer.convertUrlToId(widget.unitData!.practiceActivityVideo!);
        if (videoId != null) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }
      }
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
    final hasLink = unit?.practiceActivityLink != null && unit!.practiceActivityLink!.isNotEmpty;
    final hasUploadLink = unit?.practiceUploadLink != null && unit!.practiceUploadLink!.isNotEmpty;
    final hasVideo = unit?.practiceActivityVideo != null && unit!.practiceActivityVideo!.isNotEmpty;
    final hasQuestions = unit?.practiceActivityQuestions1 != null && unit!.practiceActivityQuestions1!.isNotEmpty;
    final canProceed = hasQuestions ? isSubmitted : true;

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
      body: unit == null || (unit.practiceActivityDescription1.isEmpty && !hasVideo && !hasQuestions)
          ? const Center(
        child: Text(
          "No practice activity available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (unit.practiceActivityDescription1.isNotEmpty)
              Text(
                unit.practiceActivityDescription1,
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 10),

            if (hasLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => _launchURL(unit.practiceActivityLink!),
                child: const Text("Go to Task Site", style: TextStyle(color: Colors.white)),
              ),

            if (hasUploadLink)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => _launchURL(unit.practiceUploadLink!),
                  child: const Text("Upload Your Answer", style: TextStyle(color: Colors.white)),
                ),
              ),

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

            if (hasQuestions)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: unit.practiceActivityQuestions1!.length,
                itemBuilder: (context, index) {
                  final question = unit.practiceActivityQuestions1![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.questionText,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            hintText: "Type your answer...",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          enabled: !isSubmitted,
                        ),
                        if (isSubmitted) ...[
                          const SizedBox(height: 5),
                          Text(
                            "Correct Answer: ${question.correctAnswer}",
                            style: const TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
                          ),
                          const Divider(),
                        ],
                      ],
                    ),
                  );
                },
              ),

            const SizedBox(height: 20),

            if (hasQuestions && !isSubmitted)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6100),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: validateAnswers,
                child: const Text("Submit", style: TextStyle(color: Colors.white)),
              ),

            if (canProceed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF010066),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PracticeActivityScreen2(
                        unitIndex: widget.unitIndex,
                        subunitIndex: widget.subunitIndex,
                        subunitTitle: widget.subunitTitle,
                        unitData: widget.unitData,
                      ),
                    ),
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
