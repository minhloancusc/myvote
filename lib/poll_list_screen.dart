import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'poll_detail_screen.dart';

class PollListScreen extends StatelessWidget {
  const PollListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('polls')
          .snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {

            final poll = docs[index];

            return ListTile(
              title: Text(poll['question']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PollDetailScreen(
                      pollId: poll.id,
                      question: poll['question'],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}