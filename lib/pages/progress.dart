import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<double> _progressData = [];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('workoutHistory') ?? [];
    setState(() {
      _progressData = history.map((value) => double.parse(value)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Workout Progress',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _progressData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Day ${index + 1}: ${_progressData[index]}'),
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
