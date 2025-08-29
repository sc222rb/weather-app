import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  final goRouter = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Weather App')),
            body: child,
            bottomNavigationBar: BottomNavBar(),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const CurrentWeatherPage(),
          ),
          GoRoute(
            path: '/info',
            builder: (context, state) => const InformationPage(),
          ),
        ],
      ),
    ],
  );
  runApp(MyApp(goRouter: goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;

  const MyApp({Key? key, required this.goRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter,
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final tabs = {'/': 0, '/info': 1};
    int currentIndex = tabs[location] ?? 0;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          GoRouter.of(context).go('/');
        } else if (index == 1) {
          GoRouter.of(context).go('/info');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
      ],
    );
  }
}

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Current Weather',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        color: Colors.blue[50], // 背景色
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                      'Check the current temperature for your location quickly and easily.\n'
                      'Data Source: OpenWeatherMap (API v2.5)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Developed by Sayaka Chishiki Jakobsson\nVersion: 1.0 • © 2025',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
