// import 'package:wallet_app/db/functions/db_function.dart';
// import 'package:wallet_app/model/buyers.dart';

// Future<void> getAllBuyers() async {
//   final values = await buyersDb.rawQuery('SELECT * FROM Buyers');
//   print(values);
//   buyerNotifier.value.clear();

//   values.forEach((map) {
//     final buyersValue = BuyersModel.fromMap(map);
//     buyerNotifier.value.add(buyersValue);
//   });
//   buyerNotifier.notifyListeners();
// }

// Future<void> addBuyers(BuyersModel value) async {
//   int id2 = await buyersDb
//       .rawInsert('INSERT INTO Buyers(name) VALUES(?)', [value.buyerName]);
//   getAllBuyers();
// }

// Future<void> deleteCategory(int id) async {
//   await buyersDb.rawDelete('DELETE FROM Buyers WHERE buyer_id = ?', [id]);
//   getAllBuyers();
// }
