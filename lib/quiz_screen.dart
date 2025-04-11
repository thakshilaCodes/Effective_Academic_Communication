import 'package:flutter/material.dart';
import 'models/all_units.dart';
import 'models/unit_model.dart';
import 'summary_screen.dart';

class QuizScreen extends StatefulWidget {
  final int unitIndex;

  QuizScreen({required this.unitIndex});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> quizQuestions;
  List<String?> selectedAnswers = [];
  bool showResults = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    quizQuestions = units[widget.unitIndex].quizQuestions;
    selectedAnswers = List.filled(quizQuestions.length, null);
  }

  void uploadAnswers() {
    if (selectedAnswers.contains(null) || selectedAnswers.contains("")) {
      setState(() {
        errorMessage = "Please answer all questions before submitting.";
      });
      return;
    }

    setState(() {
      showResults = true;
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF010066),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: quizQuestions.length,
                itemBuilder: (context, index) {
                  final question = quizQuestions[index];
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
                            question.question,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          if (question.options != null) ...question.options!.map((option) {
                            bool isCorrect = showResults &&
                                option == question.options![question.correctOptionIndex!];
                            bool isSelected = selectedAnswers[index] == option;
                            return RadioListTile<String>(
                              title: Text(
                                option,
                                style: TextStyle(
                                  color: isCorrect ? Colors.green : isSelected && showResults ? Colors.red : Colors.black,
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
                          if (question.isTextAnswer)
                            TextField(
                              onChanged: (value) {
                                selectedAnswers[index] = value;
                              },
                              decoration: InputDecoration(
                                labelText: "Your Answer",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          if (showResults && question.isTextAnswer)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Correct Answer: ${question.correctTextAnswer}",
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
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6100),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: showResults ? null : uploadAnswers,
                  child: Text("Upload Answers", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF010066),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: showResults
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryScreen(unitIndex: widget.unitIndex),
                      ),
                    );
                  }
                      : null,
                  child: Text("Next: Instructions", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
