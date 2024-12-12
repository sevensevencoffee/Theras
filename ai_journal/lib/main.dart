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
      ),
      home: const NotesGridPage(),
    );
  }
}

class NotesGridPage extends StatelessWidget {
  const NotesGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('+ New Note', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguageSettingsPage()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: 8, // Adjust based on your needs
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JournalEntryPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thursday, September 26 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The sunset color palette',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.dashboard_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              },
            ),
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
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
                    fontSize: 15,
                    color: Color(0xFFCB984F),
                    fontWeight: FontWeight.w600,
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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for mood statistics
    final Map<String, int> currentMonthMoods = {
      'Happy': 50,
      'Sad': 20,
      'Exhausted': 5,
      'Overwhelmed': 10,
    };

    final Map<String, int> moodChanges = {
      'Negative emotions': 5,
      'Gloomy days': 8,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EE),
      appBar: AppBar(
        title: const Text('Mood Analytics', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFF3F2EE),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Month Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: currentMonthMoods.entries.map((entry) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '${entry.value} days',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: entry.value / 85, // Total days tracked
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          entry.key == 'Happy' 
                              ? Colors.green 
                              : entry.key == 'Sad' 
                                  ? Colors.blue 
                                  : entry.key == 'Exhausted'
                                      ? Colors.orange
                                      : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Month-over-Month Changes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: moodChanges.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${entry.value} more ${entry.key.toLowerCase()} compared to last month',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  final List<Map<String, dynamic>> _languages = [
    {'name': 'English', 'code': 'en', 'isSelected': true},
    {'name': 'Spanish', 'code': 'es', 'isSelected': false},
    {'name': 'French', 'code': 'fr', 'isSelected': false},
    {'name': 'German', 'code': 'de', 'isSelected': false},
    {'name': 'Chinese', 'code': 'zh', 'isSelected': false},
    {'name': 'Japanese', 'code': 'ja', 'isSelected': false},
    {'name': 'Korean', 'code': 'ko', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EE),
      appBar: AppBar(
        title: const Text('Language Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFF3F2EE),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(_languages[index]['name']),
              trailing: Switch(
                value: _languages[index]['isSelected'],
                onChanged: (bool value) {
                  setState(() {
                    _languages[index]['isSelected'] = value;
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF3F2EE),
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Save selected languages and return
            List<String> selectedLanguages = _languages
                .where((lang) => lang['isSelected'])
                .map((lang) => lang['code'] as String)
                .toList();
            Navigator.pop(context, selectedLanguages);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Save Languages',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
