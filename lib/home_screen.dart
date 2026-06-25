import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_screen.dart';
import 'emergency_contact_screen.dart';
import 'medicine_reminder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _callSOS() async {
    final Uri phone = Uri.parse('tel:112');
    await launchUrl(phone);
  }

  Future<void> _openHospitals() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/hospitals+near+me',
    );
    await launchUrl(url);
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(height: 10),

                const Text(
                  "LifeLine AI 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Text(
                  "Smart Health & Emergency Assistant",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 25),

                // 🚨 SOS BIG BUTTON
                GestureDetector(
                  onTap: _callSOS,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emergency, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "EMERGENCY SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: [
                      buildCard(
                        icon: Icons.local_hospital,
                        title: "Nearby Hospitals",
                        subtitle: "Find emergency medical help",
                        color: Colors.blue,
                        onTap: _openHospitals,
                      ),

                      buildCard(
                        icon: Icons.smart_toy,
                        title: "AI Assistant",
                        subtitle: "Ask health questions instantly",
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                      ),

                      buildCard(
                        icon: Icons.contact_phone,
                        title: "Emergency Contacts",
                        subtitle: "Save important numbers",
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmergencyContactScreen(),
                            ),
                          );
                        },
                      ),

                      buildCard(
                        icon: Icons.medication,
                        title: "Medicine Reminder",
                        subtitle: "Never miss your medicines",
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MedicineReminderScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}