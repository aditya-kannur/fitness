import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final String workoutType;
  final int count;
  final int duration;

  const SummaryPage({
    required this.workoutType,
    required this.count,
    required this.duration,
    super.key,
  });

  String get _formattedTime {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Great job on completing your $workoutType workout!',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (count > 0)
              Text(
                'You completed $count reps.',
                style: const TextStyle(fontSize: 20),
              ),
            if (duration > 0)
              Text(
                'You worked out for $_formattedTime.',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            const Text(
              'Keep going and stay fit!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
