import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/pre_class_activity_screen.dart';
import 'package:eng_app_2/models/all_units.dart' as unit_data; // Alias to match HomeScreen

class IntroductionScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const IntroductionScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> paragraphs = [];
  int highlightedParagraphIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.unitData != null && widget.unitData!.introductionText.isNotEmpty) {
      paragraphs = widget.unitData!.introductionText
          .split('\n')
          .where((para) => para.trim().isNotEmpty)
          .toList();
    }
    _setupTts();
    if (paragraphs.isNotEmpty) {
      _speakNextParagraph(0);
    }
  }

  void _setupTts() {
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.4);
    flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      if (highlightedParagraphIndex + 1 < paragraphs.length) {
        _speakNextParagraph(highlightedParagraphIndex + 1);
      } else {
        setState(() {
          highlightedParagraphIndex = -1;
        });
      }
    });
  }

  void _speakNextParagraph(int index) async {
    setState(() {
      highlightedParagraphIndex = index;
    });
    await flutterTts.speak(paragraphs[index]);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unitName = widget.unitData?.unitName ?? widget.subunitTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          unitName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF010066),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Introduction",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF010066),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (widget.unitData == null || widget.unitData!.introductionText.isEmpty)
                      const Center(
                        child: Text(
                          'No introduction content available.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    else
                      ...paragraphs.asMap().entries.map((entry) {
                        int index = entry.key;
                        String para = entry.value.trim();
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (index == highlightedParagraphIndex)
                                ? Colors.orange.withOpacity(0.3)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            para,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: (index == highlightedParagraphIndex)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6100),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await flutterTts.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreClassActivityScreen(
                        unitIndex: widget.unitIndex,
                        subunitIndex: widget.subunitIndex,
                        subunitTitle: widget.subunitTitle,
                        unitData: widget.unitData,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Next: Pre-Class Activity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}