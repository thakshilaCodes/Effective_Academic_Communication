// Present Perfect Tense
import '../unit_model.dart';

final UnitModel unit3_3 = UnitModel(
  unitIndex: 8,
  unitName: "Present Perfect Tense",
  introductionText: """
Welcome to the Present Perfect Tense lesson! This is one of the most challenging tenses for English learners, but also one of the most useful.

The present perfect connects the past with the present, showing completed actions that have relevance to now. Let's master this essential tense!

Lesson Objectives
By the end of this lesson, you should be able to:
1. Understand the concept of present perfect tense and its connection between past and present.
2. Learn the structure: Subject + have/has + past participle.
3. Use present perfect for experiences, achievements, and recently completed actions.
4. Distinguish between present perfect and simple past usage.
  """,

  preClassActivityDescription: """
🎥 Watch this video about life experiences and achievements using present perfect tense!
  """,

  preClassActivityVideo: "https://www.youtube.com/watch?v=HnMwpt5wZac",

  practiceActivityDescription1: """
Step 1: Create a "Life Experiences Checklist" with 20 activities (e.g., travel to another country, try sushi, meet a celebrity).
Step 2: Mark which experiences you have had and which you haven't had.
Step 3: Write 10 sentences using present perfect (e.g., "I have traveled to Japan," "I haven't tried bungee jumping").
Step 4: Upload your checklist and sentences.

This activity helps you practice talking about life experiences!
  """,
  practiceActivityLink: "https://example.com/life-experiences",
  practiceUploadLink: "https://example.com/upload-practice-activity",

  practiceActivityDescription2: """
Complete exercises on present perfect vs. simple past.
Step 1: Access the interactive grammar exercises below.
Step 2: Complete all sections focusing on time expressions and context clues.
Step 3: Take screenshots of your completed work.
  """,
  practiceActivityLink2: "https://www.liveworksheets.com/w/en/english-second-language-esl/192847",
  practiceUploadLink2: "https://example.com/upload-practice-activity2",

  instructionsText: """
Watch the detailed explanation of present perfect tense. Focus on understanding when to use present perfect versus simple past. Pay special attention to time expressions like "ever," "never," "already," "yet," "since," and "for."
  """,

  instructionVideoId: "D-lKYaVfFhs",

  summary: """
In this lesson, we explored the present perfect tense for expressing:
- Life experiences without specific time
- Recently completed actions with present relevance
- Actions that started in the past and continue to now
We learned the formation with have/has + past participle and key time expressions.
  """,

  inClassActivity: """
Prepare for interview-style activities where you'll ask and answer about life experiences using present perfect!
  """,

  quizQuestions: [
    QuizQuestion(
      question: '1) Which sentence correctly uses present perfect?',
      options: [
        'a) I have went to Paris last year.',
        'b) I have gone to Paris.',
        'c) I have go to Paris.',
        'd) I went to Paris have.',
      ],
      correctOptionIndex: 1,
    ),
    QuizQuestion(
      question: '2) Choose the correct question: "_____ you ever _____ sushi?"',
      options: [
        'a) Did / eat',
        'b) Have / ate',
        'c) Have / eaten',
        'd) Do / eat',
      ],
      correctOptionIndex: 2,
    ),
    QuizQuestion(
      question: '3) Which time expression is used with present perfect?',
      options: [
        'a) Yesterday',
        'b) Last week',
        'c) Ever',
        'd) Ago',
      ],
      correctOptionIndex: 2,
    ),
    QuizQuestion(
      question: '4) Complete: "She _____ finished her homework."',
      options: [
        'a) have already',
        'b) has already',
        'c) already has',
        'd) already have',
      ],
      correctOptionIndex: 1,
    ),
    QuizQuestion(
      question: '5.1 Have you ever traveled to another country? Explain.',
      correctTextAnswer: 'Yes, I have traveled to India. It was an amazing experience.',
      isTextAnswer: true,
    ),
    QuizQuestion(
      question: '5.2 What is the most interesting thing you have done recently?',
      correctTextAnswer: 'I have learned to cook traditional dishes from my grandmother.',
      isTextAnswer: true,
    ),
  ],
);
