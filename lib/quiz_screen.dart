import 'package:flutter/material.dart';
import '../models/unit_data.dart';
import 'summary_screen.dart';

class QuizScreen extends StatefulWidget {
  final int unitIndex;
  QuizScreen({required this.unitIndex});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String?> selectedAnswers = [];
  bool showResults = false;
  int correctCount = 0;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(units[widget.unitIndex].quizQuestions.length, null);
  }

  void checkAnswers() {
    int count = 0;
    final unit = units[widget.unitIndex];

    for (int i = 0; i < unit.quizQuestions.length; i++) {
      if (selectedAnswers[i] == unit.quizOptions[i][unit.correctAnswers[i]]) {
        count++;
      }
    }

    setState(() {
      correctCount = count;
      showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unit = units[widget.unitIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF010066),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unit.quizQuestions[index],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          ...unit.quizOptions[index].map((option) {
                            bool isCorrect = showResults &&
                                option == unit.quizOptions[index][unit.correctAnswers[index]];
                            bool isSelected = selectedAnswers[index] == option;
                            return RadioListTile<String>(
                              title: Text(
                                option,
                                style: TextStyle(
                                  color: isCorrect
                                      ? Colors.green
                                      : isSelected && showResults
                                      ? Colors.red
                                      : Colors.black,
                                  fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              value: option,
                              groupValue: selectedAnswers[index],
                              onChanged: showResults
                                  ? null
                                  : (value) {
                                setState(() {
                                  selectedAnswers[index] = value;
                                });
                              },
                            );
                          }).toList(),
                          if (showResults)
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 5),
                              child: Text(
                                "Correct Answer: ${unit.quizOptions[index][unit.correctAnswers[index]]}",
                                style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
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
                      "You got $correctCount / ${unit.quizQuestions.length} correct!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            if (!showResults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6100),
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
                    backgroundColor: Color(0xFF010066),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
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
