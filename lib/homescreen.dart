import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eng_app_2/models/all_units.dart' as unit_data; // Alias to avoid name clash
import 'package:eng_app_2/models/unit_model.dart';
import 'introduction_screen.dart';
import 'pre_class_activity_screen.dart';
import 'instructions_screen.dart';
import 'practice_activity_screen_1.dart';
import 'quiz_screen.dart';
import 'in_class_activity_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();

  // Define the UI structure for 12 main units with subunits
  final List<Map<String, dynamic>> units = [
    {
      'title': 'Introduction to the program and getting to know each other',
      'icon': Icons.school,
      'subunits': [
        {'name': 'Introduction to the program and getting to know each other', 'unitIndex': 1},
      ]
    },
    {
      'title': 'Basic grammar skills',
      'icon': Icons.book,
      'subunits': [
        {'name': 'Basic grammar skills', 'unitIndex': 2},
        {'name': 'Word order in English', 'unitIndex': 3},
        {'name': 'Types of sentences in English', 'unitIndex': null},
      ]
    },
    {
      'title': 'Tenses',
      'icon': Icons.history_edu,
      'subunits': [
        {'name': 'Tenses', 'unitIndex': null},
        {'name': 'Simple present', 'unitIndex': null},
        {'name': 'Present continuous', 'unitIndex': null},
        {'name': 'Present perfect', 'unitIndex': null},
        {'name': 'Present perfect continuous', 'unitIndex': null},
        {'name': 'Simple past', 'unitIndex': null},
        {'name': 'Past continuous', 'unitIndex': null},
        {'name': 'Past perfect continuous', 'unitIndex': null},
        {'name': 'Simple future', 'unitIndex': null},
        {'name': 'Future Continuous', 'unitIndex': null},
        {'name': 'Future perfect', 'unitIndex': null},
      ]
    },
    {
      'title': 'Essential study skills',
      'icon': Icons.lightbulb,
      'subunits': [
        {'name': 'Essential study skills', 'unitIndex': null},
        {'name': 'Listening to lectures and taking notes', 'unitIndex': null},
        {'name': 'Vocabulary learning strategies', 'unitIndex': null},
      ]
    },
    {
      'title': 'Academic discussion and viva preparation',
      'icon': Icons.record_voice_over,
      'subunits': [
        {'name': 'Academic discussion and viva preparation', 'unitIndex': null},
        {'name': 'Introduction to viva voce', 'unitIndex': null},
        {'name': 'Structuring responses', 'unitIndex': null},
        {'name': 'Handling examiner questions', 'unitIndex': null},
      ]
    },
    {
      'title': 'Communication strategies',
      'icon': Icons.forum,
      'subunits': [
        {'name': 'Communication strategies', 'unitIndex': null},
        {'name': 'Understanding communication strategies', 'unitIndex': null},
        {'name': 'Types of questions', 'unitIndex': null},
        {'name': 'Summarizing key points in discussions', 'unitIndex': null},
        {'name': 'Paraphrasing for Better Understanding', 'unitIndex': null},
      ]
    },
    {
      'title': 'Context-Based Vocabulary Development',
      'icon': Icons.spellcheck,
      'subunits': [
        {'name': 'Context-Based Vocabulary Development', 'unitIndex': null},
        {'name': 'Changing word forms', 'unitIndex': null},
        {'name': 'Using context clues to understand unfamiliar words', 'unitIndex': null},
        {'name': 'Using formal vs. informal expressions', 'unitIndex': null},
        {'name': 'Replacing common words with academic equivalents', 'unitIndex': null},
      ]
    },
    {
      'title': 'Structuring ideas for academic discussions',
      'icon': Icons.account_tree,
      'subunits': [
        {'name': 'Structuring ideas for academic discussions', 'unitIndex': null},
        {'name': 'Organizing thoughts before speaking/writing', 'unitIndex': null},
        {'name': 'The point-evidence-explanation (PEE) method', 'unitIndex': null},
        {'name': 'Using topic sentences and supporting details', 'unitIndex': null},
      ]
    },
    {
      'title': 'Making academic presentations',
      'icon': Icons.present_to_all,
      'subunits': [
        {'name': 'Making academic presentations', 'unitIndex': null},
        {'name': 'Introduction to academic presentations', 'unitIndex': null},
        {'name': 'Tips to overcome presentation anxiety', 'unitIndex': null},
        {'name': 'Structuring presentations', 'unitIndex': null},
      ]
    },
    {
      'title': 'Enhancing coherence and logical flow',
      'icon': Icons.timeline,
      'subunits': [
        {'name': 'Enhancing coherence and logical flow', 'unitIndex': null},
        {'name': 'Maintaining the rapport of the presentations', 'unitIndex': null},
        {'name': 'Practicing and refining delivery (online and in-person)', 'unitIndex': null},
      ]
    },
    {
      'title': 'Mastering Oral Exams & Viva Voce',
      'icon': Icons.mic,
      'subunits': [
        {'name': 'Mastering Oral Exams & Viva Voce', 'unitIndex': null},
        {'name': 'Speaking with Confidence & Clarity', 'unitIndex': null},
        {'name': 'Handling Challenging & Unexpected Questions', 'unitIndex': null},
        {'name': 'Responding with Critical Thinking', 'unitIndex': null},
      ]
    },
    {
      'title': 'Reflection and self-improvement in academic communication',
      'icon': Icons.assessment,
      'subunits': [
        {'name': 'Reflection and self-improvement in academic communication', 'unitIndex': null},
        {'name': 'Self-Assessment & Reflection', 'unitIndex': null},
        {'name': 'Peer Feedback & Group Discussion', 'unitIndex': null},
      ]
    },
  ];

  // Map unitIndex to UnitModel data
  UnitModel? _getUnitData(int? unitIndex) {
    if (unitIndex == null) return null;
    return unit_data.units.firstWhere(
          (unit) => unit.unitIndex == unitIndex,
      orElse: () => null as UnitModel,
    );
  }

  void _navigateToScreen(int unitIndex, int subunitIndex) {
    final subunit = units[unitIndex]['subunits'][subunitIndex];
    final unitData = _getUnitData(subunit['unitIndex'] as int?);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IntroductionScreen(
          unitIndex: unitIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Welcome, ${widget.username}!",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF010066),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Learning Journey 📚",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF010066)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: units.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFF6100),
                        child: Icon(units[index]['icon'], color: Colors.white),
                      ),
                      title: Text(
                        units[index]['title'],
                        style: const TextStyle(
                          color: Color(0xFF010066),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: units[index]['subunits'].map<Widget>((subunit) {
                        final subunitIndex = units[index]['subunits'].indexOf(subunit);
                        return ListTile(
                          title: Text(
                            subunit['name'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          onTap: () => _navigateToScreen(index, subunitIndex),
                        );
                      }).toList(),
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