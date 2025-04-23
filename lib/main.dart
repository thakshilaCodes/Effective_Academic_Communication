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
    bool isFirstTime = box.read('first_time') ?? true; // Show onboarding if first time
    String? username = box.read('username'); // Read saved username

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstTime
          ? '/onboarding'
          : (username == null ? '/login' : '/home'),

      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(username: username ?? ''),
      },
    );
  }
}
