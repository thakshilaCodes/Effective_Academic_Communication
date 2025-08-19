import '../unit_model.dart';

final UnitModel unit3_8 = UnitModel(
  unitIndex: 13,
  unitName: "Simple Future Tense",
  introductionText: """
Welcome to the Simple Future Tense lesson! This tense is all about expressing actions that will happen later.

The simple future is essential when we want to talk about predictions, plans, promises, or decisions made at the moment of speaking. Let's explore how to express the future with confidence!

Lesson Objectives
By the end of this lesson, you should be able to:
1. Understand the concept of simple future tense for upcoming actions.
2. Learn the structure: Subject + will/shall + base verb.
3. Use simple future for predictions, promises, and spontaneous decisions.
4. Differentiate between using 'will' and other future forms (like going to).
  """,

  preClassActivityDescription: """
🎥 Watch this video explaining how to form and use simple future tense with real-life examples.
  """,

  preClassActivityVideo: "https://www.youtube.com/watch?v=qBv9UqF5dC8",

  practiceActivityDescription1: """
Step 1: Write 10 sentences about things you will do tomorrow.
Step 2: Include plans, promises, and predictions (e.g., "I will call my friend," "It will rain tomorrow").
Step 3: Create a dialogue where two friends make weekend plans.
Step 4: Upload your sentences and dialogue.
  """,
  practiceActivityLink: "https://example.com/simple-future-scenarios",
  practiceUploadLink: "https://example.com/upload-simple-future",

  practiceActivityDescription2: """
Practice future tense predictions and promises.
Step 1: Access the interactive exercises below.
Step 2: Complete the fill-in-the-blank and sentence transformation activities.
Step 3: Upload screenshots of your completed exercises.
  """,
  practiceActivityLink2: "https://www.liveworksheets.com/w/en/english-second-language-esl/216455",
  practiceUploadLink2: "https://example.com/upload-simple-future2",

  instructionsText: """
Watch the lesson carefully on how 'will' is used for the future. Notice how native speakers also use 'going to' for planned actions. Focus on when to use each form.
  """,

  instructionVideoId: "5sLx5J_WbB8",

  summary: """
In this lesson, we learned:
- Simple future is used for predictions, decisions, and promises.
- The structure is: Subject + will/shall + base verb.
- It can be used in both formal and informal speech.
- Difference between 'will' (spontaneous) and 'going to' (planned).
  """,

  inClassActivity: """
Role-play a scenario where students predict the future of technology, weather, or personal life events using 'will'.
  """,

  quizQuestions: [
    QuizQuestion(
      question: '1) Choose the correct sentence in simple future:',
      options: [
        'a) She will goes to the park tomorrow.',
        'b) She will go to the park tomorrow.',
        'c) She goes to the park tomorrow.',
        'd) She going to the park tomorrow.',
      ],
      correctOptionIndex: 1,
    ),
    QuizQuestion(
      question: '2) Complete: "I think it _____ rain tomorrow."',
      options: [
        'a) will',
        'b) is',
        'c) was',
        'd) are',
      ],
      correctOptionIndex: 0,
    ),
    QuizQuestion(
      question: '3) Which is a promise?',
      options: [
        'a) I will help you with your homework.',
        'b) I helped you with your homework.',
        'c) I am helping you with your homework.',
        'd) I had helped you with your homework.',
      ],
      correctOptionIndex: 0,
    ),
    QuizQuestion(
      question: '4) Correct form: "They _____ arrive at 6 PM."',
      options: [
        'a) will',
        'b) shall',
        'c) will to',
        'd) is will',
      ],
      correctOptionIndex: 0,
    ),
    QuizQuestion(
      question: '5.1 What will you do next weekend?',
      correctTextAnswer: 'Next weekend, I will visit my grandparents and spend time with my friends.',
      isTextAnswer: true,
    ),
    QuizQuestion(
      question: '5.2 Make a prediction about the future of technology.',
      correctTextAnswer: 'In the future, robots will help us with most household tasks.',
      isTextAnswer: true,
    ),
  ],
);
