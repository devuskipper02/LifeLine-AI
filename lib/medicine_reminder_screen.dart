import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  State<MedicineReminderScreen> createState() =>
      _MedicineReminderScreenState();
}

class _MedicineReminderScreenState
    extends State<MedicineReminderScreen> {
  final TextEditingController medicineController =
      TextEditingController();

  List<String> medicines = [];

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  Future<void> saveMedicines() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'medicines',
      jsonEncode(medicines),
    );
  }

  Future<void> loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString('medicines');

    if (data != null) {
      setState(() {
        medicines = List<String>.from(
          jsonDecode(data),
        );
      });
    }
  }

  void addMedicine() {
    if (medicineController.text.trim().isEmpty) return;

    setState(() {
      medicines.add(
        medicineController.text.trim(),
      );
    });

    saveMedicines();
    medicineController.clear();
  }

  void deleteMedicine(int index) {
    setState(() {
      medicines.removeAt(index);
    });

    saveMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: medicineController,
              decoration: const InputDecoration(
                labelText: "Medicine Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addMedicine,
                child: const Text(
                  "Add Medicine",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: medicines.isEmpty
                  ? const Center(
                      child: Text(
                        "No medicines added yet",
                      ),
                    )
                  : ListView.builder(
                      itemCount: medicines.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.medication,
                              color: Colors.purple,
                            ),
                            title: Text(
                              medicines[index],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deleteMedicine(
                                  index,
                                );
                              },
                            ),
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