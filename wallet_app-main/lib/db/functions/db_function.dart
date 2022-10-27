import 'package:sqflite/sqflite.dart';

// ValueNotifier<List<AccountModel>> accountNotifier = ValueNotifier([]);
// ValueNotifier<List<TranscationModel>> transactionNotifier = ValueNotifier([]);
// ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([]);
// ValueNotifier<List<BuyersModel>> buyerNotifier = ValueNotifier([]);

late Database walletDb;
// late Database buyersDb;
// late Database categoryDb;
// late Database transcationDb;

Future<void> initializeDb() async {
  walletDb = await openDatabase(
    "mydb6.db",
    version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Account (account_id INTEGER PRIMARY KEY, account_name TEXT, account_balance REAL,monthly_income REAL DEFAULT 0,monthly_expense REAL DEFAULT 0)');
      await db.execute(
          'CREATE TABLE Buyers (buyer_id INTEGER PRIMARY KEY, buyer_name TEXT )');
      await db.execute(
          'CREATE TABLE Category (category_id INTEGER PRIMARY KEY, category_name TEXT )');
      await db.execute(
          '''CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, date TEXT,amount REAL,type TEXT,description TEXT,status TEXT,account_id INTEGER,buyer_id INTEGER,category_id INTEGER,
     CONSTRAINT fk_account
    FOREIGN KEY (account_id)
    REFERENCES Account(account_id),
    CONSTRAINT fk_buyer
    FOREIGN KEY (buyer_id)
    REFERENCES Buyers(buyer_id),
    CONSTRAINT fk_category
    FOREIGN KEY (category_id)
    REFERENCES Category(category_id))
   ''');
    },
  );
  // buyersDb = await openDatabase("mydb.db", version: 1,
  //     onCreate: (Database db, int version) async {
  //   // When creating the db, create the table
  // });
  // categoryDb = await openDatabase("mydb.db", version: 1,
  //     onCreate: (Database db, int version) async {
  //   // When creating the db, create the table
  // });
  // transcationDb = await openDatabase("mydb.db", version: 1,
  //     onCreate: (Database db, int version) async {
  //   // When creating the db, create the table
  // });

  // if (Get.find<SettingsController>().buyerList.isEmpty) {}
  // if (Get.find<SettingsController>().categoryList.isEmpty) {}
  int? countBuyer = Sqflite.firstIntValue(
      await walletDb.rawQuery('SELECT COUNT(*) FROM Buyers'));

  int? countCategory = Sqflite.firstIntValue(
      await walletDb.rawQuery('SELECT COUNT(*) FROM Category'));

  if (countBuyer == 0) {
    await walletDb
        .rawInsert('INSERT INTO Buyers(buyer_name) VALUES("miscellaneous")');
  }
  if (countCategory == 0) {
    await walletDb.rawInsert(
        'INSERT INTO Category(category_name) VALUES("miscellaneous")');
  }
}
