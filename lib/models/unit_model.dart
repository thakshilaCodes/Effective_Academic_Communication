class UnitModel {
  final String unitName;
  final String introductionText;
  final String preClassActivityDescription;
  final String preClassActivity;
  final String submissionLink;
  final String instructionsText;
  final String instructionVideoId;
  final List<String> quizQuestions;
  final List<List<String>> quizOptions;
  final List<int> correctAnswers;
  final String summary;
  final String inClassActivity;
  final String practiceActivity;
  final String practiceActivityDescription1;
  final String practiceActivityDescription2;
  final String practiceUploadLink;
  final String practiceVideoUrl;

  UnitModel({
    required this.unitName,
    required this.introductionText,
    required this.preClassActivity,
    required this.preClassActivityDescription,
    required this.submissionLink,
    required this.instructionsText,
    required this.instructionVideoId,
    required this.quizQuestions,
    required this.quizOptions,
    required this.correctAnswers,
    required this.practiceActivity,
    required this.practiceUploadLink,
    required this.practiceVideoUrl,
    required this.practiceActivityDescription1,
    required this.practiceActivityDescription2,
    required this.summary,
    required this.inClassActivity,
  });
}
