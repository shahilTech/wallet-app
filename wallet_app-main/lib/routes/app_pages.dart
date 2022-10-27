// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:wallet_app/components/bottom_navigation/main_homescreen.dart';

import 'package:wallet_app/modules/01_Home/screen/initial_loading.dart';
import 'package:wallet_app/modules/01_Home/screen/transaction_creation.dart';
import 'package:wallet_app/routes/bindings.dart';
part 'app_routes.dart';

class TabScreen {
  int home = 0;
  int reports = 1;
  int settings = 2;
}

class AppPages {
  AppPages._();
  static const INITIAL_LOADING = Routes.INITIAL_LOADING;

  static const MAIN_PAGE = Routes.MAIN_PAGE;

  //01 HOME
  static const HOME = Routes.HOME;
  static const ADD_TRANSACTION = _Paths.ADD_TRANSACTION;

  //02 REPORTS

  static const REPORTS = Routes.REPORTS;

  //03 SETTINGS

  static const SETTINGS = Routes.SETTINGS;

  static final routes = [
    GetPage(
      name: _Paths.INITIAL_LOADING,
      page: () => const InitialLoadingScreen(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => MainHomeScreen(defaultMenuIndex: TabScreen().home),
        binding: HomeBinging(),
        children: [
          // GetPage(
          //   name: _Paths.HOME,
          //   page: () => Home(),
          // ),
          GetPage(
            name: _Paths.ADD_TRANSACTION,
            page: () => const TranscationCreationScreen(),
          )
        ]),
    GetPage(
        name: _Paths.REPORTS,
        page: () => MainHomeScreen(defaultMenuIndex: TabScreen().reports),
        binding: ReportsBinding()),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => MainHomeScreen(defaultMenuIndex: TabScreen().settings),
        binding: SettingsBinding()),
  ];
}
