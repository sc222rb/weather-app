import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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