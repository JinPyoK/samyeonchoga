import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ); // BottomNav 탭 시 PageView 이동
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.houseChimney),
            label: "Home",
            backgroundColor: Colors.orangeAccent.shade400,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.rankingStar),
            label: "Rank",
            backgroundColor: Colors.brown.shade400,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.store),
            label: "Store",
            backgroundColor: Colors.blueGrey.shade400,
          ),
        ],
      ),
    );
  }
}
