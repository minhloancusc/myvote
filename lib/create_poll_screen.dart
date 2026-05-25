import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final questionController = TextEditingController();

  final option1 = TextEditingController();
  final option2 = TextEditingController();

  Future<void> createPoll() async {
    final pollRef =
    await FirebaseFirestore.instance.collection('polls').add({
      'question': questionController.text,
    });

    await pollRef.collection('options').add({
      'text': option1.text,
      'votes': 0,
    });

    await pollRef.collection('options').add({
      'text': option2.text,
      'votes': 0,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Poll"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: "Question",
              ),
            ),

            TextField(
              controller: option1,
              decoration: const InputDecoration(
                labelText: "Option 1",
              ),
            ),

            TextField(
              controller: option2,
              decoration: const InputDecoration(
                labelText: "Option 2",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: createPoll,
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}