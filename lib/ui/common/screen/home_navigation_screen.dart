import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/ui/ad/screen/ad_screen.dart';
import 'package:samyeonchoga/ui/common/controller/compare_store_version.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';
import 'package:samyeonchoga/ui/home/screen/home_screen.dart';
import 'package:samyeonchoga/ui/rank/screen/rank_screen.dart';

class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  final _pageController = PageController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setStateGold = setState;

    compareStoreVersionAndShowDialog(context);
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GoldWidget(gold: myGold.gold),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          RankScreen(),
          AdScreen(),
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
            icon: Icon(Icons.live_tv_outlined),
            selectedIcon: Icon(
              Icons.live_tv_outlined,
              color: whiteColor,
            ),
            label: "Ad",
          ),
        ],
      ),
    );
  }
}
