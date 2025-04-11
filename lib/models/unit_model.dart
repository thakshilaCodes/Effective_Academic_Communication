class UnitModel {
  String unitName;

  int unitIndex;

  String introductionText;

  String preClassActivityDescription;
  String? preClassActivityLink;
  String? preClassActivityVideo;
  String? preClassActivityUploadLink;
  List<PreClassQuestion>? preClassQuestions;

  String instructionsText;
  String instructionVideoId;

  String practiceActivityDescription1;
  String? practiceActivityLink;
  String? practiceActivityVideo;
  List<PracticeQuestion1>? practiceActivityQuestions1;
  String? practiceUploadLink;

  String practiceActivityDescription2;
  String? practiceVideoUrl;
  String? practiceUploadLink2;
  String? practiceActivityLink2;

  String summary;
  String inClassActivity;
  List<QuizQuestion> quizQuestions;

  UnitModel({
    required this.unitIndex,
    required this.unitName,

    required this.introductionText,

    required this.preClassActivityDescription,
    this.preClassActivityLink,
    this.preClassActivityVideo,
    this.preClassQuestions,
    this.preClassActivityUploadLink,

    required this.instructionsText,
    required this.instructionVideoId,

    required this.practiceActivityDescription1,
    this.practiceActivityLink,
    this.practiceActivityVideo,
    this.practiceUploadLink,
    this.practiceActivityQuestions1,

    required this.practiceActivityDescription2,
    this.practiceVideoUrl,
    this.practiceActivityLink2,
    this.practiceUploadLink2,

    required this.summary,
    required this.inClassActivity,
    required this.quizQuestions,

  });
}

class QuizQuestion {
  String question;
  List<String>? options;
  int? correctOptionIndex;
  String? correctTextAnswer;
  bool isTextAnswer;

  QuizQuestion({
    required this.question,
    this.options,
    this.correctOptionIndex,
    this.correctTextAnswer,
    this.isTextAnswer = false,
  });

}
class PreClassQuestion {
  final String questionText;
  final String correctAnswer;

  PreClassQuestion({required this.questionText, required this.correctAnswer});
}

class PracticeQuestion1 {
  final String questionText;
  final String correctAnswer;

  PracticeQuestion1({required this.questionText, required this.correctAnswer});
}


