import 'package:flutter/material.dart';
import '../models/unit_data.dart';
import 'summary_screen.dart';  // Add the SummaryScreen import.

class QuizScreen extends StatefulWidget {
  final int unitIndex;
  QuizScreen({required this.unitIndex});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String?> selectedAnswers = [];
  bool showResults = false;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(units[widget.unitIndex].quizQuestions.length, null);
  }

  void checkAnswers() {
    setState(() {
      showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        backgroundColor: Color(0xFF010066),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white, // Background color is white now
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: unit.quizQuestions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5.0,
                    child: ListTile(
                      title: Text(
                        unit.quizQuestions[index],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Column(
                        children: unit.quizOptions[index].map((option) {
                          return RadioListTile<String>(
                            title: Text(option, style: TextStyle(color: Colors.black)),
                            value: option,
                            groupValue: selectedAnswers[index],
                            onChanged: (value) {
                              setState(() {
                                selectedAnswers[index] = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showResults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You got ${selectedAnswers.where((answer) => answer != null).length} / ${unit.quizQuestions.length} correct!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Correct Answers:",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    for (int i = 0; i < unit.quizQuestions.length; i++) ...[
                      Text(
                        "Q${i + 1}: ${unit.quizOptions[i][unit.correctAnswers[i]]}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                    ],
                  ],
                ),
              ),
            if (!showResults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6100), // Button color
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  onPressed: checkAnswers,
                  child: Text(
                    "Submit Answers",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            if (showResults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF010066), // Next button color
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // Navigate to the SummaryScreen when pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SummaryScreen(unitIndex: widget.unitIndex)),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
