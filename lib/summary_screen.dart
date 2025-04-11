import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/in_class_activity_screen.dart';

class SummaryScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const SummaryScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  void _setupTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  Future<void> _speakSummary(String text) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
    } else if (text.isNotEmpty) {
      setState(() {
        _isSpeaking = true;
      });
      await _flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.unitData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subunitTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF010066),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: unit == null || unit.summary.isEmpty
          ? const Center(
        child: Text(
          "No summary available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lesson Summary",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF010066),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  unit.summary,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Button to activate text-to-speech for summary
            ElevatedButton(
              onPressed: () => _speakSummary(unit.summary),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6100),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                _isSpeaking ? "Stop Listening" : "Listen to Summary",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // "Next" button to go to the InClassActivityScreen
            ElevatedButton(
              onPressed: () {
                _flutterTts.stop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InClassActivityScreen(
                      unitIndex: widget.unitIndex,
                      subunitIndex: widget.subunitIndex,
                      subunitTitle: widget.subunitTitle,
                      unitData: widget.unitData,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF010066),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Next: In-Class Activity",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}