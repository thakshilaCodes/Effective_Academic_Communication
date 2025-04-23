import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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

class _PreClassActivityScreenState extends State<PreClassActivityScreen> with TickerProviderStateMixin {
  List<TextEditingController> controllers = [];
  bool isSubmitted = false;
  bool allAnswered = false;
  YoutubePlayerController? _youtubeController;
  bool showVideo = false;
  late AnimationController _successAnimController;

  @override
  void initState() {
    super.initState();
    if (widget.unitData != null) {
      controllers = List.generate(
        widget.unitData!.preClassQuestions?.length ?? 0,
            (_) => TextEditingController(),
      );

      final videoUrl = widget.unitData!.preClassActivityVideo;
      if (videoUrl != null && videoUrl.isNotEmpty) {
        final videoId = YoutubePlayer.convertUrlToId(videoUrl);
        if (videoId != null) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }
      }
    }

    _successAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _successAnimController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void validateAnswers() {
    HapticFeedback.selectionClick();

    setState(() {
      allAnswered = controllers.every((controller) => controller.text.trim().isNotEmpty);
      if (!allAnswered) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please answer all questions."), backgroundColor: Colors.red),
        );
        return;
      }

      isSubmitted = true;
    });
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch the link."), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.unitData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF010066),
        title: Text(widget.subunitTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: unit == null
          ? const Center(child: Text("No pre-class activity available.", style: TextStyle(fontSize: 18)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: isSubmitted
                  ? Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text("Activity submitted!", style: TextStyle(color: Colors.green)),
                  ],
                ),
              )
                  : const SizedBox(),
            ),

            const SizedBox(height: 10),
            Text("📝 Activity Overview",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(unit.preClassActivityDescription, style: const TextStyle(fontSize: 15, height: 1.5)),

            const SizedBox(height: 20),

            if (_youtubeController != null)
              ExpansionTile(
                leading: const Icon(Icons.play_circle_fill),
                title: const Text("Watch Video", style: TextStyle(fontWeight: FontWeight.w600)),
                onExpansionChanged: (value) => setState(() => showVideo = value),
                children: [YoutubePlayer(controller: _youtubeController!)],
              ),

            if (unit.preClassActivityLink != null && unit.preClassActivityLink!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(unit.preClassActivityLink!),
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text("Open Related Site"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ),

            const SizedBox(height: 20),

            if (unit.preClassQuestions != null && unit.preClassQuestions!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🧠 Answer These", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListView.builder(
                    itemCount: unit.preClassQuestions!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final isAnswered = controllers[index].text.isNotEmpty;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isAnswered ? Colors.lightGreen.shade50 : Colors.grey.shade100,
                          border: Border.all(color: isAnswered ? Colors.green : Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Q${index + 1}: ${unit.preClassQuestions![index].questionText}",
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            TextField(
                              controller: controllers[index],
                              enabled: !isSubmitted,
                              maxLines: null,
                              onChanged: (_) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: "Your answer...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (isSubmitted)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  child: Text(
                                    "✔️ Correct Answer: ${unit.preClassQuestions![index].correctAnswer}",
                                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),

                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check,color: Colors.white,size: 20,),
                    label: const Text("Submit Answers",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    onPressed: validateAnswers,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6100),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward,size: 20,),
              label: const Text("Next",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                backgroundColor: (isSubmitted || unit.preClassQuestions?.isEmpty == true)
                    ? const Color(0xFF010066)
                    : Colors.grey,
                minimumSize: const Size(double.infinity, 50),

              ),
              onPressed: (isSubmitted || unit.preClassQuestions?.isEmpty == true)
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
            ),
          ],
        ),
      ),
    );
  }
}
