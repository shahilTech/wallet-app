// ignore: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/components/bottom_navigation/bottom_navigationbarview.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';
import 'package:wallet_app/modules/02_Reports/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/screens/settings.dart';
import 'package:wallet_app/modules/01_Home/screen/home.dart';
import 'package:wallet_app/modules/02_Reports/screens/reports.dart';

class MainHomeScreen extends StatefulWidget {
  final int defaultMenuIndex;
  const MainHomeScreen({Key? key, required this.defaultMenuIndex})
      : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreen();
}

class _MainHomeScreen extends State<MainHomeScreen> {
  int _pageIndex = 0;
  final tabPages = const [
    Home(),
    Reports(),
    SettingsScreen(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    setState(() {
      _pageIndex = widget.defaultMenuIndex;
    });
    _pageController = PageController(initialPage: _pageIndex);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBarView(
        pageIndex: _pageIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }

  //home page change on swipe
  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  // home page change
  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
      if (_pageIndex == 0) {
        Get.put(HomeController());
        Get.find<ReportsController>().filteringdata = [];
        Get.find<ReportsController>().update();
      } else if (_pageIndex == 1) {
        Get.put(ReportsController());
      } else {
        Get.put(SettingsController());
        Get.find<ReportsController>().filteringdata = [];
        Get.find<ReportsController>().update();
      }
    });
  }
}
