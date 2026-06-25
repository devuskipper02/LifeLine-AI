import 'package:flutter/material.dart';
import 'services/notification_service.dart';

class ReminderScreen extends StatefulWidget {
const ReminderScreen({super.key});

@override
State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
final TextEditingController medicineController =
TextEditingController();

List<String> reminders = [];

void addReminder() {
if (medicineController.text.trim().isEmpty) return;


setState(() {
  reminders.add(medicineController.text);
});

medicineController.clear();


}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Medicine Reminder"),
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
TextField(
controller: medicineController,
decoration: const InputDecoration(
labelText: "Medicine Name",
border: OutlineInputBorder(),
),
),


        const SizedBox(height: 15),

        ElevatedButton(
          onPressed: addReminder,
          child: const Text("Add Reminder"),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            NotificationService.showNotification();
          },
          child: const Text("Test Notification"),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.medication),
                  title: Text(reminders[index]),
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
