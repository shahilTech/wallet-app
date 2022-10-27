import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/components/constants/constants.dart';

import 'package:wallet_app/model/accounts.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _editNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Get.find<SettingsController>().getAccountData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Add Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Enter Account Name',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Account Balance',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _balanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        onAddButtonClicked();
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text('Add Account')),
                ),
                GetBuilder<SettingsController>(
                  builder: (_) {
                    return Expanded(
                      flex: 0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // final data = _.[index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.defaultDialog(
                                    title: "Update Account_name",
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: _editNameController,
                                        ),
                                        kHeight20,
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.find<SettingsController>()
                                                  .editAccount(
                                                      _editNameController.text,
                                                      _.accountList[index]
                                                          .accountId!);
                                              Get.back();
                                            },
                                            child: const Text('submit'))
                                      ],
                                    ));
                              },
                              title: Text(
                                _.accountList[index].accountName.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  // ignore: unnecessary_string_escapes
                                  "Balance:\₹${_.accountList[index].balance.toInt()}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    int index1 = Get.find<HomeController>()
                                        .transactionLists
                                        .indexWhere((element) =>
                                            element.accountName ==
                                            _.accountList[index].accountName);

                                    if (index1 != -1) {
                                      Get.snackbar("Can't delete",
                                          "Account is used for transactions",
                                          backgroundColor: Colors.grey,
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else {
                                      Get.find<SettingsController>().deleteData(
                                          _.accountList[index].accountId!);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          );
                        },
                        itemCount: _.accountList.length,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddButtonClicked() async {
    final name = _nameController.text;
    final balance = double.parse(_balanceController.text.trim());
    if (name.isEmpty || _balanceController.text.isEmpty) {
      return;
    }
    final data = AccountModel(
        accountName: name,
        balance: balance,
        monthlyIncome: 0.0,
        monthlyExpesne: 0.0);
    Get.find<SettingsController>().addAccountData(data);
    _nameController.clear();
    _balanceController.clear();
  }
}
