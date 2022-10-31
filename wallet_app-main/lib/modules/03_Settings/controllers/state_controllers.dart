import 'package:get/get.dart';
import 'package:wallet_app/components/print.dart';
import 'package:wallet_app/db/functions/db_function.dart';
import 'package:wallet_app/model/accounts.dart';
import 'package:wallet_app/model/buyers.dart';
import 'package:wallet_app/model/category.dart';

class SettingsController extends GetxController {
  List<AccountModel> accountList = [];
  List<CategoryModel> categoryList = [];
  List<BuyersModel> buyerList = [];
  @override
  void onInit() {
    super.onInit();
    customPrint('Settings  Controller Initiialized');

    getAccountData();
  }

  // --------------------------------------------------------------------------
  // ===============   A C C O U N T   =================
  // --------------------------------------------------------------------------

  Future<void> getAccountData() async {
    final values = await walletDb.rawQuery('SELECT * FROM Account');
    customPrint(values);
    // accountNotifier.value.clear();
    accountList.clear();

    for (var map in values) {
      final accountValue = AccountModel.fromMap(map);
      // accountNotifier.value.add(accountValue);
      accountList.add(accountValue);
    }

    print(accountList[0].balance);
    print('//////////////');

    // accountNotifier.notifyListeners();
    update();
  }

  Future<void> addAccountData(AccountModel value) async {
    await walletDb.rawInsert(
        'INSERT INTO Account(account_name, account_balance,monthly_income,monthly_expense) VALUES(?, ?,?,?)',
        [
          value.accountName,
          value.balance,
          value.monthlyIncome,
          value.monthlyExpesne
        ]);

    getAccountData();
    update();
  }

  Future<void> deleteData(int id) async {
    await walletDb.rawDelete('DELETE FROM Account WHERE account_id = ?', [id]);
    getAccountData();
    update();
  }

  editAccount(String name, int id) async {
    // For updating
    await walletDb.rawUpdate(
        'UPDATE Account SET account_name = ? WHERE account_id = ?', [name, id]);
    getAccountData();
    update();
  }
  // --------------------------------------------------------------------------
  // ===============   C A T E G O R I E S  =================
  // --------------------------------------------------------------------------

  Future<void> getAllCategories() async {
    final values = await walletDb.rawQuery('SELECT * FROM Category');
    customPrint(values);
    categoryList.clear();

    for (var map in values) {
      final categoryValue = CategoryModel.fromMap(map);
      // categoryNotifier.value.add(categoryValue);
      // categ.value.add(categoryValue);
      categoryList.add(categoryValue);
    }
    update();
  }

  Future<void> addCategories(CategoryModel value) async {
    if (categoryList.isEmpty) {
      // walletDb.rawInsert(
      //     'INSERT INTO Category(category_name) VALUES("select category")');
    }
    await walletDb.rawInsert(
        'INSERT INTO Category(category_name) VALUES(?)', [value.categoryName]);
    update();

    getAllCategories();
  }

  Future<void> deleteCategory(int id) async {
    await walletDb
        .rawDelete('DELETE FROM Category WHERE category_id = ?', [id]);
    getAllCategories();
  }

  // --------------------------------------------------------------------------
  // ===============   B U Y E R S   =================
  // --------------------------------------------------------------------------

  Future<void> getAllBuyers() async {
    final values = await walletDb.rawQuery('SELECT * FROM Buyers');
    customPrint(values);
    buyerList.clear();

    // ignore: avoid_function_literals_in_foreach_calls
    values.forEach((map) {
      final buyersValue = BuyersModel.fromMap(map);
      buyerList.add(buyersValue);
    });
    update();
  }

  Future<void> addBuyers(BuyersModel value) async {
    if (buyerList.isEmpty) {
      // walletDb
      //     .rawInsert('INSERT INTO Buyers(buyer_name) VALUES("select buyer")');
    }
    await walletDb.rawInsert(
        'INSERT INTO Buyers(buyer_name) VALUES(?)', [value.buyerName]);
    getAllBuyers();
    update();
  }

  Future<void> deleteBuyer(int id) async {
    await walletDb.rawDelete('DELETE FROM Buyers WHERE buyer_id = ?', [id]);
    getAllBuyers();
  }
}
