import 'package:flutter/material.dart';
import 'introduction_screen.dart'; // Add relevant screens here
import 'pre_class_activity_screen.dart';
import 'instructions_screen.dart';
import 'practice_activity_screen_1.dart';
import 'practice_activity_screen_2.dart';
import 'quiz_screen.dart';
import 'in_class_activity_screen.dart';
import 'summary_screen.dart';

class UnitScreen extends StatelessWidget {
  final int unitIndex;

  UnitScreen({required this.unitIndex});

  // Subunit names for each unit (you can modify these to match your actual subunit titles)
  List<String> getSubunits(int unitIndex) {
    final subunitMap = {
      0: ["Introduction", "Pre-Class Activity", "Instructions", "Practice Activity", "Quiz", "In-Class Activity", "Summary"],
      1: ["Introduction", "Pre-Class Activity", "Instructions", "Practice Activity", "Quiz", "In-Class Activity", "Summary"],
      // Add more subunits for each unit as required
    };
    return subunitMap[unitIndex] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final subunits = getSubunits(unitIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text("Unit ${unitIndex + 1} Subunits"),
        backgroundColor: const Color(0xFF010066),
      ),
      body: ListView.builder(
        itemCount: subunits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subunits[index]), // Display subunit name
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to the corresponding screen for the subunit
              _navigateToScreen(context, unitIndex, index);
            },
          );
        },
      ),
    );
  }

  // Navigate to the screen corresponding to the subunit
  void _navigateToScreen(BuildContext context, int unitIndex, int subunitIndex) {
    // Here you map subunitIndex to corresponding screens (you can add more conditions if needed)
    Widget screen;

    switch (subunitIndex) {
      case 0:
        screen = IntroductionScreen(unitIndex: unitIndex);
        break;
      case 1:
        screen = PreClassActivityScreen(unitIndex: unitIndex);
        break;
      case 2:
        screen = InstructionsScreen(unitIndex: unitIndex);
        break;
      case 3:
        screen = PracticeActivityScreen(unitIndex: unitIndex);
        break;
      case 4:
        screen = PracticeActivityScreen2(unitIndex: unitIndex);
        break;
      case 5:
        screen = QuizScreen(unitIndex: unitIndex);
        break;
      case 6:
        screen = InClassActivityScreen(unitIndex: unitIndex);
        break;
      case 7:
        screen = SummaryScreen(unitIndex: unitIndex);
        break;
      default:
        screen = IntroductionScreen(unitIndex: unitIndex); // Default to IntroductionScreen
    }

    // Navigate to the selected screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
