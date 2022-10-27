// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL_LOADING = _Paths.INITIAL_LOADING;

//MAIN PAGE
  static const MAIN_PAGE = _Paths.MAIN_PAGE;

  //01 HOME
  static const HOME = _Paths.HOME;
  static const ADD_TRANSACTION = _Paths.ADD_TRANSACTION;
//02 REPORTS
  static const REPORTS = _Paths.REPORTS;

//03 SETTINGS
  static const SETTINGS = _Paths.SETTINGS;
}

abstract class _Paths {
  static const INITIAL_LOADING = '/init-loading';
//MAIN PAGE
  static const MAIN_PAGE = '/main-page';

//01 HOME
  static const HOME = MAIN_PAGE + '/home';
  static const ADD_TRANSACTION = HOME + '/add-transaction';
//02 REPORTS

  static const REPORTS = MAIN_PAGE + '/resports';

//03 SETTINGS
  static const SETTINGS = MAIN_PAGE + '/settings';
}
