import 'package:flutter/material.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/summary_screen.dart';

class QuizScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const QuizScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

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
    quizQuestions = widget.unitData?.quizQuestions ?? [];
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
        title: Text(
          widget.subunitTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF010066),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: widget.unitData == null || quizQuestions.isEmpty
          ? const Center(
        child: Text(
          "No quiz questions available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: quizQuestions.length,
                itemBuilder: (context, index) {
                  final question = quizQuestions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (question.options != null)
                            ...question.options!.map((option) {
                              bool isCorrect = showResults &&
                                  option == question.options![question.correctOptionIndex!];
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
                                    fontWeight:
                                    isCorrect ? FontWeight.bold : FontWeight.normal,
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
                              decoration: const InputDecoration(
                                labelText: "Your Answer",
                                border: OutlineInputBorder(),
                              ),
                              enabled: !showResults,
                            ),
                          if (showResults && question.isTextAnswer)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Correct Answer: ${question.correctTextAnswer}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
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
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6100),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: showResults ? null : uploadAnswers,
                    child: const Text(
                      "Submit Answers",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF010066),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: showResults
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryScreen(
                            unitIndex: widget.unitIndex,
                            subunitIndex: widget.subunitIndex,
                            subunitTitle: widget.subunitTitle,
                            unitData: widget.unitData,
                          ),
                        ),
                      );
                    }
                        : null,
                    child: const Text(
                      "Next: Summary",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}