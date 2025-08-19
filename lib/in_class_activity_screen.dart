import 'package:flutter/material.dart';
import 'package:eng_app_2/models/unit_model.dart';
import 'package:eng_app_2/homescreen.dart';
import 'package:get_storage/get_storage.dart'; // Assuming username is stored here

class InClassActivityScreen extends StatefulWidget {
  final int unitIndex;
  final int subunitIndex;
  final String subunitTitle;
  final UnitModel? unitData;

  const InClassActivityScreen({
    Key? key,
    required this.unitIndex,
    required this.subunitIndex,
    required this.subunitTitle,
    this.unitData,
  }) : super(key: key);

  @override
  _InClassActivityScreenState createState() => _InClassActivityScreenState();
}

class _InClassActivityScreenState extends State<InClassActivityScreen> {
  final box = GetStorage(); // For retrieving username

  @override
  Widget build(BuildContext context) {
    final unit = widget.unitData;
    final username = box.read('username') ?? 'User'; // Fallback if username not stored

    return SafeArea(
      child: Scaffold(
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
        body: unit == null || unit.inClassActivity.isEmpty
            ? const Center(
          child: Text(
            "No in-class activity available.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "In-Class Activity",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF010066),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    unit.inClassActivity,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Unlock the next unit and redirect to HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        username: username,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6100),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Finish",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}