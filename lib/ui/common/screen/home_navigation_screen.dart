import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/home/screen/home_screen.dart';
import 'package:samyeonchoga/ui/rank/screen/rank_screen.dart';
import 'package:samyeonchoga/ui/store/screen/store_screen.dart';

class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  final _pageController = PageController();

  int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          RankScreen(),
          StoreScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          _currentIndex = index;
          _pageController.jumpToPage(index);
          setState(() {});
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.houseChimney),
            selectedIcon: FaIcon(
              FontAwesomeIcons.houseChimney,
              color: whiteColor,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.rankingStar),
            selectedIcon: FaIcon(
              FontAwesomeIcons.rankingStar,
              color: whiteColor,
            ),
            label: "Rank",
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.store),
            selectedIcon: FaIcon(
              FontAwesomeIcons.store,
              color: whiteColor,
            ),
            label: "Store",
          ),
        ],
      ),
    );
  }
}
