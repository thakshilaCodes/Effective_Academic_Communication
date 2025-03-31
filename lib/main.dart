import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'homescreen.dart';
import 'login.dart';
import 'onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isFirstTime = box.read('first_time') ?? true; // Default: true
    String? username = box.read('username'); // Retrieve saved username

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstTime
          ? '/onboarding'  // If first time, show onboarding
          : (username == null ? '/login' : '/home'), // Otherwise, check login

      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(username: username ?? ''),
      },
    );
  }
}
