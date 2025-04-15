import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});
  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();

  Future<void> addEmployee() async {
    String name = nameController.text;
    String age = ageController.text;
    String location = locationController.text;

    if (name.isNotEmpty && age.isNotEmpty && location.isNotEmpty) {
      await FirebaseFirestore.instance.collection('employees').add({
        'name': name,
        'age': int.tryParse(age),
        'location': location,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context); // Go back after adding
    } else {
      // Show error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addEmployee,
        child: Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Employee",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "_Form",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputField("Name:", "Enter your name", nameController),
            inputField("Age:", "Enter age", ageController),
            inputField("Location:", "Enter location", locationController),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: addEmployee,
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
