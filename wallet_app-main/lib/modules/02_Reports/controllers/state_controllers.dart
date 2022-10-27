import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/components/print.dart';
import 'package:wallet_app/modules/01_Home/models/transaction_list.dart';

import '../../../db/functions/db_function.dart';

class FilterData {
  String? filterType; //account category buyer date
  String? filterName; //
  FilterData({this.filterType, this.filterName});
}

class ReportsController extends GetxController {
  List oneWeek = [];
  List<TransactionList> categoryFilter = [];
  List<TransactionList> buyersFilter = [];
  List<TransactionList> filteredList = [];
  List showfilterd = [];

  // List filteringDatas = ["Category", "Buyers", "Account", "Date"];
  List filteredData = [
    'Tea',
    'Ikka Shop',
    'Fed Bank',
    '16-08-2022 - 20-08-2022'
  ];
  List<FilterData> filteringdata = [];

  @override
  void onInit() {
    super.onInit();
    customPrint('reports controller Initialized');
    // Get.put(HomeController());
    // Get.put(SettingsController());
    // test();
  }

  // filterByWeek() {
  //   final now = DateTime.now();
  //   var now1w = now.subtract(Duration(days: 7));
  //   var now_1m = DateTime(now.year, now.month - 1, now.day);
  //   var now_1y = DateTime(now.year - 1, now.month, now.day);
  //   List list = Get.find<HomeController>().transactionList;
  //   for (var dateString in list) {
  //     final date = DateTime.parse(dateString.date);
  //     if (date.isAfter(now1w)) {
  //       oneWeek.insert(0, dateString);
  //     }
  //   }
  //   update();
  // }

  // test() async {
  //   print('**********************test fn***************');
  //   var query =
  //       "SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id INNER JOIN Buyers on Buyers.buyer_id=Transactions.Buyer_id WHERE  Transactions.date BETWEEN '2022-06-01 00:00:00' AND '2022-06-17 00:00:00'";
  //   try {
  //     final values = await walletDb.rawQuery(query);
  //     print(values);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // --------------------------------------------------------------------------
  // ===============   F I L T E R  B Y  S E A R C H   =================
  // --------------------------------------------------------------------------

  filterBySearch(String value) async {
    final values = await walletDb.rawQuery(
      'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id INNER JOIN Buyers on Buyers.buyer_id=Transactions.Buyer_id WHERE description LIKE "$value%" OR Category.category_name LIKE "$value%"',
    );

    filteredList.clear();

    // transactionList.clear();
    for (var map in values) {
      final transactionvalue = TransactionList.fromMap(map);
      filteredList.insert(0, transactionvalue);
    }
    update();
  }
  // --------------------------------------------------------------------------
  // ===============   A L L   O T H E R   F I L T E R S  =================
  // --------------------------------------------------------------------------

  filters(
      int? accountId,
      int? buyerId,
      int? categoryId,
      DateTime? startDate,
      DateTime? endDate,
      String? accountName,
      String? buyerName,
      String? categoryName) async {
    var where = '';
    if (accountId != null) {
      filteringdata
          .add(FilterData(filterName: accountName, filterType: 'Account'));
      if (where.isEmpty) {
        where = 'Account.account_id = $accountId';
      } else {
        where += ' AND  Account.account_id = $accountId ';
      }
    } else {
      filteredData
          .remove(FilterData(filterName: accountName, filterType: 'Account'));
    }
    if (buyerId != null) {
      filteringdata.add(FilterData(filterName: buyerName, filterType: 'Buyer'));

      if (where.isEmpty) {
        where = 'Buyers.buyer_id = $buyerId';
      } else {
        where += ' AND Buyers.buyer_id = $buyerId ';
      }
    } else {
      filteredData
          .remove(FilterData(filterName: buyerName, filterType: 'Buyer'));
    }
    if (categoryId != null) {
      filteringdata
          .add(FilterData(filterName: categoryName, filterType: 'Category'));

      if (where.isEmpty) {
        where = 'Category.category_id = $categoryId';
      } else {
        where += ' AND Category.category_id = $categoryId';
      }
    } else {
      filteredData
          .remove(FilterData(filterName: categoryName, filterType: 'Category'));
    }

    // if (startDate != null || endDate != null) {
    // if (where.isEmpty) {
    //   where = 'date BETWEEN $startDate OR $endDate';
    // } else {
    //   where += 'AND date BETWEEN $startDate OR $endDate';
    // }
    String startDates = '';
    String endDates = '';
    final date = DateFormat('dd-MMMM-yy');

    if (startDate != null && endDate != null) {
      startDates = date.format(startDate);
      endDates = date.format(endDate);
      filteringdata.add(FilterData(
          filterName: "$startDates to $endDates", filterType: 'Date'));

      if (where.isEmpty) {
        where = 'Transactions.date BETWEEN "$startDate" AND "$endDate"';
      } else {
        where += 'AND Transactions.date BETWEEN "$startDate" AND "$endDate"';
      }
      // }
      //  else if (endDate == null) {
      //   if (where.isEmpty) {
      //     where = 'date BETWEEN $startDate OR $endDate';
      //   } else {
      //     where += 'AND date BETWEEN $startDate OR $endDate';
      //   }
      // } else if (startDate == null) {
      //   if (where.isEmpty) {
      //     where = 'date BETWEEN $startDate OR $endDate';
      //   } else {
      //     where += 'AND date BETWEEN $startDate OR $endDate';
      //   }
      // }
    } else {
      filteringdata.remove(FilterData(
          filterName: "$startDates to $endDates", filterType: 'Date'));
    }
    final values = await walletDb.rawQuery(
      'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id INNER JOIN Buyers on Buyers.buyer_id=Transactions.Buyer_id WHERE  $where',
    );
    filteredList.clear();

    // transactionList.clear();
    for (var map in values) {
      final transactionvalue = TransactionList.fromMap(map);
      filteredList.insert(0, transactionvalue);
    }
    update();
  }
  // filterByCategory(int id) async {
  //   final values = await walletDb.rawQuery(
  //       'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id WHERE Category.Category_id=?',
  //       [id]);
  //   print('category');
  //   print(values);
  //   dateFilter.clear();
  //   print('**************************');

  //   // transactionList.clear();
  //   values.forEach((map) {
  //     final transactionvalue = TransactionList.fromMap(map);
  //     dateFilter.insert(0, transactionvalue);
  //   });
  //   update();
  // }

  // filterByBuyers(int id) async {
  //   final values = await walletDb.rawQuery(
  //       'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id INNER JOIN Buyers on Buyers.buyer_id=Transactions.Buyer_id WHERE Buyers.buyer_id=?',
  //       [id]);
  //   print('buyers');
  //   print(values);
  //   dateFilter.clear();
  //   print('hsbusbfsbjfbsfhbsjfbjsfbjsfh');

  //   // transactionList.clear();
  //   values.forEach((map) {
  //     final transactionvalue = TransactionList.fromMap(map);
  //     dateFilter.insert(0, transactionvalue);
  //   });
  //   update();
  // }

  // filterByAccount(int id) async {
  //   final values = await walletDb.rawQuery(
  //       'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id INNER JOIN Buyers on Buyers.buyer_id=Transactions.Buyer_id WHERE Account.account_id = ?',
  //       [id]);
  //   print('account');
  //   print(values);
  //   dateFilter.clear();
  //   print('hsbusbfsbjfbsfhbsjfbjsfbjsfh');

  //   // transactionList.clear();
  //   values.forEach((map) {
  //     final transactionvalue = TransactionList.fromMap(map);
  //     dateFilter.insert(0, transactionvalue);
  //   });
  //   update();
  // }

  listFilters() async {
    final values = await walletDb.rawQuery(
        'SELECT date,amount,Category.category_name,Account.account_name,type,description FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id');
    customPrint('list filters');
    filteredList.clear();

    // transactionList.clear();
    for (var map in values) {
      final transactionvalue = TransactionList.fromMap(map);
      filteredList.insert(0, transactionvalue);
    }
    if (showfilterd.isEmpty) {
      showfilterd.clear();
    }
    update();
  }
}
