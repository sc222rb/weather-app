import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/current_weather_page.dart';
import 'pages/information_page.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

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
