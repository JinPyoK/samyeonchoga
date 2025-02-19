import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/context/global_context.dart';
import 'package:samyeonchoga/repository/gold/gold_repository.dart';
import 'package:samyeonchoga/ui/ad/screen/ad_screen.dart';
import 'package:samyeonchoga/ui/common/controller/compare_store_version.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';
import 'package:samyeonchoga/ui/home/screen/home_screen.dart';
import 'package:samyeonchoga/ui/rank/screen/rank_screen.dart';

int myGolds = 0;

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

    globalContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      compareStoreVersionAndShowDialog(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        showCustomDialog(
          context,
          defaultAction: false,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("게임을 종료하시겠습니까?"),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text("취소"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: redColor),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text("게임 종료"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const _CommonAppBar(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [HomeScreen(), RankScreen(), AdScreen()],
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
              label: "Ranking",
            ),
            NavigationDestination(
              icon: Icon(Icons.live_tv_outlined),
              selectedIcon: Icon(Icons.live_tv_outlined, color: whiteColor),
              label: "Ad",
            ),
          ],
        ),
      ),
    );
  }
}

class _CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const _CommonAppBar();

  @override
  State<_CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<_CommonAppBar> {
  Future<void> _getGolds() async {
    myGolds = await GoldRepository().getGolds();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setStateGold = setState;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getGolds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: GoldWidget(gold: myGolds),
        ),
      ],
    );
  }
}
