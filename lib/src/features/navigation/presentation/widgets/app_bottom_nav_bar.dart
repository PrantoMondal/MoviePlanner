import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/utils/extensions.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      return const SizedBox();
    }

    return BottomNavigationBar(
      backgroundColor: context.theme.canvasColor,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: context.theme.primaryColor,
      unselectedItemColor:
      context.theme.colorScheme.secondary.withAlpha(250),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      iconSize: AppValues.icon_24,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: "AI chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
