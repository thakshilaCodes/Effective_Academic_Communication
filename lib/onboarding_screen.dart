import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              buildPage(
                image: 'assets/onboarding/ob1.jpg',
                title: '🗣️ Speak Like a Pro!',
                description: 'Tired of sounding like a robot? 🤖 Let’s fix that! Our app will help you master English pronunciation, one word at a time. Get ready to talk like a native and impress everyone! 🎤✨',
              ),
              buildPage(
                image: 'assets/onboarding/ob5.png',
                title: '👂 Listen, Laugh & Learn!',
                description: 'Who said grammar and pronunciation have to be boring? 🤓🎉 We’ve packed this app with hilarious examples, fun challenges, and real-world practice. Get ready to laugh and learn! 😆📚',
              ),
            ],
          ),

          // Smooth Page Indicator
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.blue,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ),

          // Next Button
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_controller.page == 1) {
                  Navigator.pushReplacementNamed(context, '/home'); // Last page, go to home
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({required String image, required String title, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300), // Ensure you have these images in assets
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
