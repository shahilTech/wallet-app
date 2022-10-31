import 'package:get/get.dart';
import 'package:wallet_app/components/print.dart';
import 'package:wallet_app/db/functions/db_function.dart';
import 'package:wallet_app/model/accounts.dart';
import 'package:wallet_app/model/transaction.dart';
import 'package:wallet_app/modules/01_Home/models/amount_details.dart';
import 'package:wallet_app/modules/01_Home/models/calcincome_expense.dart';
import 'package:wallet_app/modules/01_Home/models/incomexpense_values.dart';
import 'package:wallet_app/modules/01_Home/models/transaction_list.dart';
import 'package:wallet_app/modules/02_Reports/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class HomeController extends GetxController {
  List<TranscationModel> transactionList = [];
  List<AmountDetails> amountDetailsList = [];
  List<TransactionList> transactionLists = [];
  List<Calc> calcList = [];
  late List accountList = [];
  List<IncomeValues> incomeValuesList = [];
  List<ExpenseValues> expenseValuesList = [];
  List<AccountModel> accountDataList = [];

  // List accountListH = Get.find<SettingsController>().accountList;
  // List categoryListH = Get.find<SettingsController>().categoryList;

  // List buyerListH = Get.find<SettingsController>().buyerList;

  double incomeAmount = 0.0;
  double expenseAmount = 0.0;
  bool isSwithed = false;

  @override
  void onInit() {
    super.onInit();
    customPrint('Home Controller Initiialized');
    Get.put(SettingsController());
    Get.put(ReportsController());
    accountList = Get.find<SettingsController>().accountList;
    getAllTransaction();

    // totalamount();
    transactionListDetails();

    Get.find<SettingsController>().getAllCategories();
    Get.find<SettingsController>().getAccountData();
    Get.find<SettingsController>().getAllBuyers();
    // Get.find<HomeController>().getAllTransaction();
  }
  // --------------------------------------------------------------------------
  // =============== G E T   A L L  T R A N S A C T I O N    =================
  // --------------------------------------------------------------------------

  Future<void> getAllTransaction() async {
    final values = await walletDb.rawQuery('SELECT * FROM Transactions');

    customPrint(values);
    transactionList.clear();

    // ignore: avoid_function_literals_in_foreach_calls
    values.forEach((map) {
      final transactionvalue = TranscationModel.fromMap(map);
      transactionList.insert(0, transactionvalue);
    });
    update();
  }

// --------------------------------------------------------------------------
  // ===============    A D D  T R A N S A C T I O N    =================
  // --------------------------------------------------------------------------

  Future<void> addTransaction(TranscationModel value) async {
    await walletDb.rawInsert(
        'INSERT INTO Transactions(  date,amount,type,description,status,account_id,category_id,buyer_id) VALUES(?, ?,?,?,?,?,?,?)',
        [
          value.date,
          value.amount,
          value.type,
          value.description,
          value.status,
          value.accountId,
          value.categoryId,
          value.buyerId
        ]);
    double income = 0;
    double expense = 0;
    // double balance =0;
    int accountId = value.accountId;
    int index1 = accountList.indexWhere((element) {
      return element.accountId == value.accountId;
    });

   
    if (index1 != -1) {
      print(value.type);
      if (value.type == 'Income') {
        // print(accountList[inde);
        // accountList[index1].monthlyIncome =
        //     accountList[index1].monthlyIncome + value.amount;
        accountList[index1].monthlyIncome =
            accountList[index1].monthlyIncome + value.amount;
        income = accountList[index1].monthlyIncome;

        accountList[index1].balance =
            accountList[index1].balance + value.amount;
        double newbalance = accountList[index1].balance;


      //  double newbalance = accountDataList[0].balance + value.amount;

       print(value.type);
        // print(values);
      print('///////////////////////////////////');

        
        // accountList[index1].balance =
        //     accountList[index1].balance + value.amount;
        //     balance=accountList[index1].balance;

        // double balance = accountList[index1].balance;

      //   final values = await walletDb.rawQuery('SELECT * FROM Account WHERE account_id=$accountId');
        

    //    await db.rawUpdate('''
    // UPDATE Account
    // account_balance = ?, monthly_income = ? 
    // WHERE _id = ?
    // ''', 
    // ['Susan', 13, 1]);


        await walletDb.rawInsert(
            'UPDATE Account SET account_balance = ?, monthly_income =? WHERE account_id =$accountId',
            [
              newbalance,
              income
              ]);

       
        // await walletDb.rawInsert(
        //     'UPDATE Account SET account_balance=? WHERE account_id=$accountId',
        //     [balance]);

        // print('aaa income=$income bal=$balance');
      } else {
        // accountList[index1].monthlyExpesne =
        //     accountList[index1].monthlyExpesne + value.amount;
        // expense = accountList[index1].monthlyExpesne;

        accountList[index1].monthlyExpesne =
            accountList[index1].monthlyExpesne + value.amount;
        expense = accountList[index1].monthlyExpesne;

        // accountList[index1].balance =
        //     accountList[index1].balance - value.amount;

        // double balance = accountList[index1].balance;
        // print('aaa income=$income bal=$balance');

        await walletDb.rawInsert(
            'UPDATE Account SET monthly_expense = ?  WHERE account_id=$accountId',
            [expense]);
        // await walletDb.rawInsert(
        //     'UPDATE Account SET account_balance = ? WHERE account_id=$accountId',
        //     [balance]);
      }
    }

     final values = await walletDb.rawQuery('SELECT * FROM Account WHERE account_id=$accountId');
    values.forEach((map) {
      final accountData = AccountModel.fromMap(map);
      accountDataList.insert(0, accountData);
    });

    transactionListDetails();
    // getAllTransaction();
  }

  // --------------------------------------------------------------------------
  // =============== M O N T H W I S E  I N C O M E  &  E X P E N S E    =================
  // --------------------------------------------------------------------------

  monthWiseCalculations(int id) async {
    customPrint('monthwise income expense');
    final date = DateTime.now();
    final firstDay = DateTime(date.year, date.month);

    int transactionIncomeCheck =
        transactionLists.indexWhere((element) => element.type == "Income");
    if (transactionIncomeCheck != -1) {
      final valuesIncome = await walletDb.rawQuery(
          'SELECT SUM(amount),amount,Account.account_id FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id WHERE Account.account_id=$id AND Transactions.type="Income" AND date BETWEEN "$firstDay" AND "$date"');
      customPrint('mothly calculations Income');

      incomeValuesList.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      valuesIncome.forEach((map) {
        final incomeValues = IncomeValues.fromMap(map);
        incomeValuesList.add(incomeValues);
      });

      await walletDb.rawInsert(
          'UPDATE Account SET monthly_income=? WHERE account_id=$id',
          [incomeValuesList[0].sumAmount]);

      int index2 = accountList.indexWhere(
          (element) => element.accountId == incomeValuesList[0].accountId);
      if (index2 != -1) {
        accountList[index2].monthlyIncome = incomeValuesList[0].sumAmount;
      }
    }

    // print('LLLLLLLLLLLLL');
    // print(incomeValuesList);
    // print('LLLLLLLLLLLLL');
    // double income = 0;
    // for (var list in incomeValuesList) {
    //   print(list.accountId);
    //   int accountId = list.accountId;
    //   int index1 = accountList.indexWhere((element) {
    //     print(element.accountId);
    //     print(list.accountId);

    //     return element.accountId == list.accountId;
    //   });
    //   if (index1 != -1) {
    //     accountList[index1].monthlyIncome =
    //         accountList[index1].monthlyIncome + list.incomeAmount;
    //     income = accountList[index1].monthlyIncome;
    //     print(accountList[index1].monthlyIncome);
    //     await walletDb.rawInsert(
    //         'UPDATE Account SET monthly_income=? WHERE account_id=$accountId',
    //         [income]);
    //   }
    // }
    // print('ahsdbasbdsdadadd');
    // print("${income}      duszuyz");
    int transactionExpenseCheck =
        transactionLists.indexWhere((element) => element.type == "Expense");
    if (transactionExpenseCheck != -1) {
      final valuesExpense = await walletDb.rawQuery(
          'SELECT SUM(amount),amount,Account.account_id FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id WHERE Transactions.type="Expense" AND Account.account_id=$id AND date BETWEEN "$firstDay" AND "$date"');
      customPrint('mothly calculations expense');

      expenseValuesList.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      valuesExpense.forEach((map) {
        final expenseValues = ExpenseValues.fromMap(map);
        expenseValuesList.add(expenseValues);
      });

      await walletDb.rawInsert(
          'UPDATE Account SET monthly_expense=? WHERE account_id=$id',
          [expenseValuesList[0].sumAmount]);
      int index3 = accountList.indexWhere(
          (element) => element.accountId == expenseValuesList[0].accountId);
      if (index3 != -1) {
        accountList[index3].monthlyExpesne = expenseValuesList[0].sumAmount;
      }
    }


    update();
  }

// --------------------------------------------------------------------------
  // ===============   T R A N S A C T I O N  L I S T   S H O W I N G   =================
  // --------------------------------------------------------------------------
  transactionListDetails() async {
    final values = await walletDb.rawQuery(
        'SELECT date,amount,Category.category_name,Account.account_name,type,description,Account.account_id FROM Transactions INNER JOIN Category on Category.category_id=Transactions.category_id INNER JOIN Account on Account.account_id=Transactions.account_id');
    customPrint('transaction List Printing');
    customPrint(values);
    transactionLists.clear();
    customPrint('---------------------------');
    // transactionList.clear();
    for (var map in values) {
      final transactionvalue = TransactionList.fromMap(map);
      transactionLists.insert(0, transactionvalue);

      if (transactionvalue.type == 'Income') {}
    }
    update();
  }

  // amountDetails() async {
  //   final values = await walletDb.rawQuery(
  //       'SELECT Account.account_name,type,amount FROM Transactions  INNER JOIN Account  ');
  //   print('***************');
  //   print(values);
  //   amountDetailsList.clear();

  //   values.forEach((map) {
  //     final transactionvalue = AmountDetails.fromMap(map);
  //     amountDetailsList.insert(0, transactionvalue);
  //   });
  // }

}
