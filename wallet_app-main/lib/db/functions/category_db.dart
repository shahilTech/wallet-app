// import 'package:flutter/widgets.dart';
// import 'package:wallet_app/db/functions/db_function.dart';
// import 'package:wallet_app/model/accounts.dart';
// import 'package:wallet_app/model/category.dart';

// ValueNotifier categ = ValueNotifier([]);
// Future<void> getAllCategories() async {
//   final values = await categoryDb.rawQuery('SELECT * FROM Category');
//   print(values);
//   categoryNotifier.value.clear();

//   values.forEach((map) {
//     final categoryValue = CategoryModel.fromMap(map);
//     categoryNotifier.value.add(categoryValue);
//     categ.value.add(categoryValue);
//   });
//   categoryNotifier.notifyListeners();
// }

// Future<void> addCategories(CategoryModel value) async {
//   int id2 = await categoryDb
//       .rawInsert('INSERT INTO Category(name) VALUES(?)', [value.categoryName]);
//   categoryNotifier.notifyListeners();

//   getAllCategories();
// }

// Future<void> deleteCategory(int id) async {
//   await categoryDb
//       .rawDelete('DELETE FROM Category WHERE category_id = ?', [id]);
//   getAllCategories();
// }
