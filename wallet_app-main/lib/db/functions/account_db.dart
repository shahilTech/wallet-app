// import 'package:wallet_app/db/functions/db_function.dart';
// import 'package:wallet_app/model/accounts.dart';

// Future<void> getAccountData() async {
//   final values = await accountDb.rawQuery('SELECT * FROM Account');
//   print(values);
//   accountNotifier.value.clear();

//   values.forEach((map) {
//     final accountValue = AccountModel.fromMap(map);
//     accountNotifier.value.add(accountValue);
//   });
//   accountNotifier.notifyListeners();
// }

// Future<void> addAccountData(AccountModel value) async {
//   int id2 = await accountDb.rawInsert(
//       'INSERT INTO Account(name, balance) VALUES(?, ?)',
//       [value.accountName, value.balance]);
//   getAccountData();
// }

// Future<void> deleteData(int id) async {
//   await accountDb.rawDelete('DELETE FROM Account WHERE account_id = ?', [id]);
//   getAccountData();
// }
