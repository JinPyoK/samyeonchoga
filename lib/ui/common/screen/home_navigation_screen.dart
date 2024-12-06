import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/auth/oauth_provider.dart';
import 'package:samyeonchoga/provider/gold/gold_provider.dart';
import 'package:samyeonchoga/ui/common/widget/gold.dart';
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
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(getDisplayName() ?? '닉네임 없음'),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Gold(gold: gold),
          ),
        ],
      ),
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
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
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
