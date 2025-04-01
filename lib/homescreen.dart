import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'introduction_screen.dart';
import 'pre_class_activity_screen.dart';
import 'instructions_screen.dart';
import 'practice_activity_screen_1.dart';
import 'quiz_screen.dart';
import 'in_class_activity_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();

  final List<String> unitTitles = [
    "Introduction & Getting Started",
    "Basic Grammar Skills",
    "Tenses Mastery",
    "Study Skills Essentials",
    "Academic Discussions & Viva",
    "Communication Strategies",
    "Vocabulary Development",
    "Structuring Ideas for Discussions",
    "Effective Academic Presentations",
    "Logical Flow & Coherence",
    "Mastering Oral Exams & Viva",
    "Reflection & Self-Improvement"
  ];

  final List<IconData> unitIcons = [
    Icons.school,
    Icons.book,
    Icons.history_edu,
    Icons.lightbulb,
    Icons.record_voice_over,
    Icons.forum,
    Icons.spellcheck,
    Icons.account_tree,
    Icons.present_to_all,
    Icons.timeline,
    Icons.mic,
    Icons.assessment,
  ];

  List<bool> unitUnlocked = List.generate(12, (index) => index == 0);

  void _unlockNextUnit(int index) {
    if (index < 11) {
      setState(() {
        unitUnlocked[index + 1] = true;
      });
    }
  }

  void _navigateToUnit(int index) {
    if (unitUnlocked[index]) {
      Widget screen;
      switch (index) {
        case 0:
          screen = IntroductionScreen(unitIndex: index);
          break;
        case 1:
          screen = PreClassActivityScreen(unitIndex: index);
          break;
        case 2:
          screen = InstructionsScreen(unitIndex: index);
          break;
        case 3:
          screen = PracticeActivityScreen(unitIndex: index);
          break;
        case 4:
          screen = QuizScreen(unitIndex: index);
          break;
        case 5:
          screen = InClassActivityScreen(unitIndex: index);
          break;
        case 6:
          screen = SummaryScreen(unitIndex: index);
          break;
        default:
          screen = IntroductionScreen(unitIndex: index);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
      _unlockNextUnit(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Welcome, ${widget.username}!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF010066),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Learning Journey 📚",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF010066)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: unitTitles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToUnit(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: unitUnlocked[index] ? Color(0xFF010066) : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(2, 2)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: unitUnlocked[index] ? Color(0xFFFF6100) : Colors.grey,
                            child: Icon(
                              unitIcons[index],
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              unitTitles[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}