import 'package:flutter/material.dart';
import 'create_poll_screen.dart';
import 'poll_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Poll"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreatePollScreen(),
                ),
              );
            },
            child: const Text("Create Poll"),
          ),

          Expanded(
            child: PollListScreen(),
          ),
        ],
      ),
    );
  }
}