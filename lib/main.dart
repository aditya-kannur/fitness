import 'package:flutter/material.dart';
import 'package:fitness/pages/pushups.dart';
import 'package:fitness/pages/sitUps.dart';
import 'package:fitness/pages/squats.dart';
import 'package:fitness/pages/lunges.dart';
import 'package:fitness/pages/plank.dart';
import 'package:fitness/pages/plan.dart';
import 'package:fitness/pages/history.dart';
import 'package:fitness/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
  brightness: _isDarkMode ? Brightness.dark : Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: _isDarkMode ? Brightness.dark : Brightness.light,
  ),
  useMaterial3: true,
),

      home: HomeScreen(toggleTheme: _toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Fitness App!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WorkoutScreen()),
                );
              },
              child: const Text('Start Workout'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanPage()),
                );
              },
              child: const Text('Workout Plan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
              child: const Text('Workout History'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressPage()),
                );
              },
              child: const Text('Workout Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Push Ups'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PushUpsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Sit Ups'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SitUpsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Squats'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SquatsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Lunges'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LungesPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Plank'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlankPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
