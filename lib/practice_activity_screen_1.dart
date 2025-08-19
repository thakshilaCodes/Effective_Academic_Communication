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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Answers submitted!"), backgroundColor: Colors.green),
        );
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
    final hasLink = unit?.practiceActivityLink?.isNotEmpty ?? false;
    final hasUploadLink = unit?.practiceUploadLink?.isNotEmpty ?? false;
    final hasVideo = unit?.practiceActivityVideo?.isNotEmpty ?? false;
    final hasQuestions = unit?.practiceActivityQuestions1?.isNotEmpty ?? false;
    final canProceed = hasQuestions ? isSubmitted : true;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.subunitTitle, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
          backgroundColor: const Color(0xFF010066),
        ),
        body: unit == null
            ? const Center(child: Text("No practice activity available.", style: TextStyle(fontSize: 18, color: Colors.grey)))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (unit.practiceActivityDescription1.isNotEmpty)
                Card(
                  color: Colors.indigo.shade50,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      unit.practiceActivityDescription1,
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ),
      
              const SizedBox(height: 20),
      
              if (hasLink)
                _buildButton("Go to Task Site", unit!.practiceActivityLink!, Colors.blue),
      
              if (hasUploadLink)
                _buildButton("Upload Your Answer", unit!.practiceUploadLink!, Colors.green),
      
              if (hasVideo && _youtubeController != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                  itemCount: unit!.practiceActivityQuestions1!.length,
                  itemBuilder: (context, index) {
                    final question = unit.practiceActivityQuestions1![index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Q${index + 1}: ${question.questionText}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: controllers[index],
                              decoration: InputDecoration(
                                hintText: "Type your answer...",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                              enabled: !isSubmitted,
                            ),
                            if (isSubmitted)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Correct Answer: ${question.correctAnswer}",
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      
              if (hasQuestions && !isSubmitted)
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6100),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: validateAnswers,
                  label: const Text("Submit Answers", style: TextStyle(fontSize: 16)),
                ),
      
              if (canProceed)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
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
                    label: const Text("Next: Practice Activity 2", style: TextStyle(fontSize: 16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label, String url, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.link),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () => _launchURL(url),
        label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
