import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PollDetailScreen extends StatelessWidget {

  final String pollId;
  final String question;

  const PollDetailScreen({
    super.key,
    required this.pollId,
    required this.question,
  });

  Future<void> vote(DocumentReference optionRef) async {

    await optionRef.update({
      'votes': FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(question),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('polls')
            .doc(pollId)
            .collection('options')
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final options = snapshot.data!.docs;

          int totalVotes = 0;

          for (var doc in options) {
            totalVotes += (doc['votes'] as int);
          }

          return ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {

              final option = options[index];

              final votes = option['votes'];

              double percent = 0;

              if (totalVotes > 0) {
                percent = votes / totalVotes * 100;
              }

              return Card(
                child: ListTile(
                  title: Text(option['text']),
                  subtitle: Text(
                    "${percent.toStringAsFixed(1)} %",
                  ),
                  trailing: Text("$votes votes"),
                  onTap: () => vote(option.reference),
                ),
              );
            },
          );
        },
      ),
    );
  }
}