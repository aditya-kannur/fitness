import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController _goalController = TextEditingController();
  String _goal = '';
  int _seconds = 0;
  int _lungesCount = 0;
  int _sitUpsCount = 0;
  int _pushUpsCount = 0;
  int _squatsCount = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _loadGoal();
    _loadTime();
    _loadProgress();
  }

  void _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = prefs.getString('goal') ?? '';
      _goalController.text = _goal;
    });
  }

  void _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('goal', _goalController.text);
    setState(() {
      _goal = _goalController.text;
    });
  }

  void _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _seconds = prefs.getInt('planTime') ?? 0;
    });
  }

  void _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('planTime', _seconds);
  }

  void _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lungesCount = prefs.getInt('lungesCount') ?? 0;
      _sitUpsCount = prefs.getInt('sitUpsCount') ?? 0;
      _pushUpsCount = prefs.getInt('pushUpsCount') ?? 0;
      _squatsCount = prefs.getInt('squatsCount') ?? 0;
    });
  }

  void _resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lungesCount');
    await prefs.remove('sitUpsCount');
    await prefs.remove('pushUpsCount');
    await prefs.remove('squatsCount');
    setState(() {
      _lungesCount = 0;
      _sitUpsCount = 0;
      _pushUpsCount = 0;
      _squatsCount = 0;
    });
  }

  void _startTimer() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
      _saveTime();
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
    _saveTime();
  }

  String get _formattedTime {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Set your workout goals and track your progress here.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                labelText: 'Enter your workout goal',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGoal,
              child: const Text('Save Goal'),
            ),
            const SizedBox(height: 20),
            Text(
              'Your current goal: $_goal',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Time: $_formattedTime',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Workout Progress',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Lunges: $_lungesCount',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Sit-ups: $_sitUpsCount',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Push-ups: $_pushUpsCount',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Squats: $_squatsCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetProgress,
              child: const Text('Reset Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
