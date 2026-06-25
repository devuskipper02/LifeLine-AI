import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() =>
      _EmergencyContactScreenState();
}

class _EmergencyContactScreenState
    extends State<EmergencyContactScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  String savedName = "";
  String savedPhone = "";

  void saveContact() {
    setState(() {
      savedName = nameController.text;
      savedPhone = phoneController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Emergency Contact Saved"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Contact Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveContact,
              child: const Text("Save Contact"),
            ),

            const SizedBox(height: 30),

            if (savedName.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.contact_phone),
                  title: Text(savedName),
                  subtitle: Text(savedPhone),
                ),
              ),
          ],
        ),
      ),
    );
  }
}