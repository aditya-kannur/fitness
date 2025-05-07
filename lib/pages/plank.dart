import 'package:flutter/material.dart';
import 'dart:async';

class PlankPage extends StatefulWidget {
  const PlankPage({super.key});

  @override
  _PlankPageState createState() => _PlankPageState();
}

class _PlankPageState extends State<PlankPage> {
  int _seconds = 60;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plank'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hold a plank for 1 minute.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Time remaining: $_seconds seconds',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
