import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary.dart';

class LungesPage extends StatefulWidget {
  const LungesPage({super.key});

  @override
  _LungesPageState createState() => _LungesPageState();
}

class _LungesPageState extends State<LungesPage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  void _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('lungesCount') ?? 0;
    });
  }

  void _incrementCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count++;
      prefs.setInt('lungesCount', _count);
    });
  }

  void _decrementCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_count > 0) {
        _count--;
        prefs.setInt('lungesCount', _count);
      }
    });
  }

  void _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('lungesCount', _count);
  }

  void _completeWorkout() {
    _saveProgress();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          workoutType: 'Lunges',
          count: _count,
          duration: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lunges Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Do 3 sets of 15 lunges per leg.',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset('assets/lunges.png'), // Add an image for the workout
              const SizedBox(height: 20),
              Text(
                'Count: $_count',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _decrementCount,
                    child: const Text('-'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _incrementCount,
                    child: const Text('+'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProgress,
                child: const Text('Save Progress'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _completeWorkout,
                child: const Text('Complete Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
