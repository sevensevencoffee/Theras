import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        fontFamily: 'Courier New',
      ),
      home: const JournalEntryPage(),
    );
  }
}

class JournalEntryPage extends StatefulWidget {
  const JournalEntryPage({super.key});

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  final TextEditingController _journalController = TextEditingController();
  String? _aiResponse;
  String _currentDisplayedResponse = '';
  Timer? _timer;
  bool _isTyping = false;

  @override
  void dispose() {
    _journalController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTypingEffect(String text) {
    if (_isTyping) return;
    
    setState(() {
      _isTyping = true;
      _currentDisplayedResponse = '';
      _aiResponse = text;
    });

    int index = 0;
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (index < text.length) {
        setState(() {
          _currentDisplayedResponse = text.substring(0, index + 1);
          index++;
        });
      } else {
        _isTyping = false;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F2EE),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friday, December 11 2024 at 9:00am',
              style: TextStyle(
                fontFamily: 'Courier New',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.cloud, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'new york city, ny',
                  style: TextStyle(
                    fontFamily: 'Courier New',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _journalController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Write your thoughts...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                fontFamily: 'Courier New',
                fontSize: 16,
                color: Colors.black.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            if (_aiResponse != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2EE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _currentDisplayedResponse,
                  style: const TextStyle(
                    fontFamily: 'Courier New',
                    fontSize: 15,
                    color: Color(0xFFCB984F),
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF3F2EE),
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.mic, color: Colors.grey[600]),
              onPressed: () {
                // TODO: Implement voice input
              },
            ),
            IconButton(
              icon: Icon(Icons.star, color: Colors.grey[600]),
              onPressed: () {
                _startTypingEffect(
                  "I hear you, and it sounds like you're going through a challenging time. "
                  "Remember that test scores don't define your worth. You're capable of so much more "
                  "than you realize, and setbacks are just temporary obstacles on your path to success."
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.check, color: Colors.grey[600]),
              onPressed: () {
                // Left empty for now since we're using the star button
              },
            ),
          ],
        ),
      ),
    );
  }
}
