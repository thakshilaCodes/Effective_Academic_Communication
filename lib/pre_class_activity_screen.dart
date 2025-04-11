import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/instructions_screen.dart';

class PreClassActivityScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const PreClassActivityScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  State<PreClassActivityScreen> createState() => _PreClassActivityScreenState();
}

class _PreClassActivityScreenState extends State<PreClassActivityScreen> {
  List<TextEditingController> controllers = [];
  bool isSubmitted = false;
  bool allAnswered = false;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (widget.unitData != null) {
      controllers = List.generate(
        widget.unitData!.preClassQuestions?.length ?? 0,
            (_) => TextEditingController(),
      );

      if (widget.unitData!.preClassActivityVideo != null &&
          widget.unitData!.preClassActivityVideo!.isNotEmpty) {
        final videoId = YoutubePlayer.convertUrlToId(widget.unitData!.preClassActivityVideo!);
        if (videoId != null) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void validateAnswers() {
    setState(() {
      if (widget.unitData?.preClassQuestions != null &&
          widget.unitData!.preClassQuestions!.isNotEmpty) {
        allAnswered = controllers.every((controller) => controller.text.trim().isNotEmpty);
        if (!allAnswered) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please answer all questions!"), backgroundColor: Colors.red),
          );
          return;
        }
      }
      isSubmitted = true;
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
    final hasVideo = unit?.preClassActivityVideo != null && unit!.preClassActivityVideo!.isNotEmpty;
    final hasExternalTaskLink =
        unit?.preClassActivityLink != null && unit!.preClassActivityLink!.isNotEmpty;
    final hasUploadLink =
        unit?.preClassActivityUploadLink != null && unit!.preClassActivityUploadLink!.isNotEmpty;
    final hasQuestions = unit?.preClassQuestions != null && unit!.preClassQuestions!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF010066),
        title: Text(
          widget.subunitTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: unit == null
          ? const Center(
        child: Text(
          "No pre-class activity available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              unit.preClassActivityDescription,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (hasExternalTaskLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () => _launchURL(unit.preClassActivityLink!),
                child: const Text("Go to Activity Site"),
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

            const SizedBox(height: 20),

            if (hasQuestions)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                itemCount: unit.preClassQuestions!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit.preClassQuestions![index].questionText,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),

            if (!hasQuestions && !hasVideo && hasUploadLink)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () => _launchURL(unit.preClassActivityUploadLink!),
                child: const Text("Submit Your Work"),
              ),

            const SizedBox(height: 10),

            if (hasQuestions)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6100),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: validateAnswers,
                child: const Text("Submit Answers", style: TextStyle(color: Colors.white)),
              ),

            const SizedBox(height: 10),

            if (isSubmitted && hasQuestions)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Correct Answers:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    for (int i = 0; i < unit.preClassQuestions!.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "${unit.preClassQuestions![i].questionText}\n✅ ${unit.preClassQuestions![i].correctAnswer}",
                          style: const TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: (isSubmitted || !hasQuestions)
                    ? const Color(0xFF010066)
                    : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: (isSubmitted || !hasQuestions)
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionsScreen(
                      unitIndex: widget.unitIndex,
                      subunitIndex: widget.subunitIndex,
                      subunitTitle: widget.subunitTitle,
                      unitData: widget.unitData,
                    ),
                  ),
                );
              }
                  : null,
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}