import 'package:flutter/material.dart';
import '../widgets/workout_card.dart';
import 'Lunges.dart';
import 'Situps.dart';
import 'Pushups.dart';
import 'Squats.dart';
import 'Plan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            WorkoutCard(
              title: 'Lunges',
              icon: Icons.directions_run,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LungesPage()),
                );
              },
            ),
            // WorkoutCard(
            //   title: 'Sit-ups',
            //   icon: Icons.fitness_center,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SitupsPage()),
            //     );
            //   },
            // ),
            // WorkoutCard(
            //   title: 'Push-ups',
            //   icon: Icons.push_pin,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const PushupsPage()),
            //     );
            //   },
            // ),
            WorkoutCard(
              title: 'Squats',
              icon: Icons.accessibility_new,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SquatsPage()),
                );
              },
            ),
            WorkoutCard(
              title: 'Plan',
              icon: Icons.calendar_today,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
