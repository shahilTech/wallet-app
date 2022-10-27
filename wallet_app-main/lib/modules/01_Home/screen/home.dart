import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/components/constants/constants.dart';
import 'package:wallet_app/db/functions/db_function.dart';

import 'package:wallet_app/modules/01_Home/components/account_pageview.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';

import 'package:wallet_app/routes/app_pages.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // int lastday = DateTime(now.year, now.month + 1, 0).day;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // Get.find<HomeController>().totalamount();
      // Get.find<HomeController>().getAllTransaction();
      Get.find<HomeController>().transactionListDetails();
    });

    // Get.find<SettingsController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Wallet App',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              letterSpacing: 1),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountPageView(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Transactions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            kHeight10,
            Expanded(
              child: GetBuilder<HomeController>(builder: (_) {
                return _.transactionLists.isEmpty
                    ? const Center(
                        child: Text('No Transactions'),
                      )
                    : ListView.builder(
                        primary: true,
                        reverse: false,
                        itemBuilder: (context, index) {
                          final data = _.transactionLists[index];
                          final date = DateFormat('dd-MMMM-yy');
                          final parsedDate = DateTime.parse(data.date);
                          final dateOut = date.format(parsedDate);
                          return Card(
                            color: data.type == "Income"
                                ? const Color.fromARGB(255, 147, 227, 150)
                                : const Color.fromARGB(255, 220, 129, 123),
                            child: ListTile(
                              title: data.description!.isNotEmpty
                                  ? Text(
                                      data.description.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : Text(
                                      data.categoryName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                              // Text(_.transactionList[index].categoryName),
                              subtitle: Text(dateOut),

                              trailing: Column(
                                children: [
                                  kHeight10,
                                  Text(
                                    // ignore: unnecessary_string_escapes
                                    "\₹${data.amount.toInt()}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(data.accountName)
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: _.transactionLists.length,
                      );
              }),
            ),
            kHeight40
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 112, 140, 163),
        onPressed: () async {
          //         List<Map<String, Object?>> fetchedBalance =
          //             await walletDb.rawQuery("SELECT * FROM Account  ");
          //         print('jr ${fetchedBalance');

          //         fetchedBalance.forEach((map) {

          // });

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (ctx) => TranscationCreationScreen(),
          //     ));
          Get.toNamed(AppPages.HOME + AppPages.ADD_TRANSACTION);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:wallet_app/db/functions/db_function.dart';
// import 'package:wallet_app/model/accounts.dart';

// class Home extends StatelessWidget {
//   final _dataController = TextEditingController();
//   final _balanceController = TextEditingController();

//   Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     getAllData();
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           TextFormField(
//             controller: _dataController,
//           ),
//           TextFormField(
//             controller: _balanceController,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 onAddButtonClicked();
//               },
//               child: const Text('add')),
//           Expanded(
//             child: ValueListenableBuilder(
//                 valueListenable: accountNotifier,
//                 builder:
//                     (BuildContext ctx, List<AccountModel> list, Widget? _) {
//                   return ListView.builder(
//                     itemBuilder: (BuildContext ctx, int index) {
//                       final data = list[index];
//                       return ListTile(
//                         title: Text(data.accountName),
//                       );
//                     },
//                     itemCount: list.length,
//                   );
//                 }),
//           )
//         ],
//       )),
//     );
//   }

//   Future<void> onAddButtonClicked() async {
//     final name = _dataController.text.trim();
//     final balance = _balanceController.text.trim();
//     if (name.isEmpty || balance.isEmpty) {
//       return;
//     }
//     final data = AccountModel(accountName: name, balance: balance);
//     addData(data);
//   }
// }
