import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          buildPage(
            Icons.emergency,
            "Emergency SOS",
            "One tap emergency help",
            Colors.red,
          ),
          buildPage(
            Icons.local_hospital,
            "Nearby Hospitals",
            "Find nearest hospitals instantly",
            Colors.blue,
          ),
          buildPage(
            Icons.smart_toy,
            "AI Assistant",
            "Ask health questions anytime",
            Colors.green,
            context,
          ),
        ],
      ),
    );
  }

  Widget buildPage(
    IconData icon,
    String title,
    String subtitle,
    Color color, [
    BuildContext? context,
  ]) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 120, color: color),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),

            if (context != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text("Get Started"),
              ),
          ],
        ),
      ),
    );
  }
}