import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/unit_data.dart';
import 'pre_class_activity_screen.dart';

class IntroductionScreen extends StatefulWidget {
  final int unitIndex;
  IntroductionScreen({required this.unitIndex});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> wordChunks = [];
  PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _prepareText();
    _speakText(wordChunks[0]);
  }

  void _prepareText() {
    final unit = units[widget.unitIndex];
    List<String> words = unit.introductionText.split(' ');
    for (int i = 0; i < words.length; i += 60) {
      wordChunks.add(words.sublist(i, i + 60 > words.length ? words.length : i + 60).join(' '));
    }
  }

  void _speakText(String text) async {
    await flutterTts.stop();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          unit.unitName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color(0xFF010066),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: wordChunks.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                  _speakText(wordChunks[index]);
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        wordChunks[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue, size: 32),
                  onPressed: currentIndex > 0
                      ? () => _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
                      : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.blue, size: 32),
                  onPressed: currentIndex < wordChunks.length - 1
                      ? () => _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
                      : null,
                ),
              ],
            ),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6100),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreClassActivityScreen(unitIndex: widget.unitIndex),
                    ),
                  );
                },
                child: Text(
                  "Next: Pre-Class Activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}