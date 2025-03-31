import 'package:eng_app_2/practice_activity_screen_1.dart';
import 'package:eng_app_2/pre_class_activity_screen.dart';
import 'package:eng_app_2/quiz_screen.dart';
import 'package:eng_app_2/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'in_class_activity_screen.dart';
import 'instructions_screen.dart';
import 'introduction_screen.dart'; // import your screens for each unit
// Add imports for other unit screens here...

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();

  // List of unit topics
  final List<String> unitTitles = [
    "Introduction to the program and getting to know each other",
    "Basic grammar skills",
    "Tenses",
    "Essential study skills",
    "Academic discussion and viva preparation",
    "Communication strategies",
    "Context-Based Vocabulary Development",
    "Structuring ideas for academic discussions",
    "Making academic presentations",
    "Enhancing coherence and logical flow",
    "Mastering Oral Exams & Viva Voce",
    "Reflection and self-improvement in academic communication"
  ];

  // List to track which units are unlocked
  List<bool> unitUnlocked = List.generate(12, (index) => index == 0);

  // Function to unlock next unit
  void _unlockNextUnit(int index) {
    if (index < 11) {
      setState(() {
        unitUnlocked[index + 1] = true;
      });
    }
  }

  // Function to navigate to the respective unit screen
  void _navigateToUnit(int index) {
    if (unitUnlocked[index]) {
      // Navigate based on the index
      Widget screen;
      switch (index) {
        case 0:
          screen = IntroductionScreen(unitIndex:index);
          break;
        case 1:
          screen = PreClassActivityScreen(unitIndex: index,);
          break;
        case 2:
          screen = InstructionsScreen(unitIndex: index,);
          break;
        case 3:
          screen = PracticeActivityScreen(unitIndex: index,);
          break;
        case 4:
          screen = QuizScreen(unitIndex: index,);
          break;
        case 5:
          screen = InClassActivityScreen(unitIndex: index,);
          break;
        case 6:
          screen = SummaryScreen(unitIndex: index,);
          break;
      // Add more cases for each unit
        default:
          screen = IntroductionScreen(unitIndex:index); // Default screen
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
      _unlockNextUnit(index); // Unlock the next unit after opening
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      appBar: AppBar(
        title: Text(
          "Welcome, ${widget.username}!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF010066), // Deep Blue
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            Text(
              "Your Learning Journey 📚",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF010066),
              ),
            ),
            SizedBox(height: 10),

            // Scrollable List of Units
            Expanded(
              child: ListView.builder(
                itemCount: unitTitles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToUnit(index),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: unitUnlocked[index] ? Color(0xFF010066) : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: unitUnlocked[index] ? Color(0xFFFF6100) : Colors.grey,
                            child: Icon(
                              unitUnlocked[index] ? Icons.lock_open : Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              unitTitles[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
