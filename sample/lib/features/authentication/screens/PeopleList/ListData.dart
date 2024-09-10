import 'package:flutter/material.dart';
import 'package:sample/Models/UserData.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus package

class BirthdayDetailPage extends StatelessWidget {
  final User user;

  BirthdayDetailPage({required this.user});

  final TextEditingController _versesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.userName} Birthday'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Born: ${user.dateOfBirth}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _versesController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Enter Verses',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final String verses = _versesController.text;
                if (verses.isNotEmpty) {
                  // Use Share Plus to share the entered text
                  Share.share(verses);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter some verses.')),
                  );
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
