import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/components/constants/constants.dart';

import 'package:wallet_app/model/accounts.dart';
import 'package:wallet_app/model/buyers.dart';
import 'package:wallet_app/model/category.dart';
import 'package:wallet_app/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

enum TransactionType { income, expense }

class TranscationCreationScreen extends StatefulWidget {
  const TranscationCreationScreen({Key? key}) : super(key: key);

  @override
  State<TranscationCreationScreen> createState() =>
      _TranscationCreationScreenState();
}

class _TranscationCreationScreenState extends State<TranscationCreationScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var transactionType;
  String transactionvalue = '';
  var _dropDownValueCategory = '';
  var _dropDownValueAccount = '';
  var _dropDownValueBuyer = '';
  bool isSwithed = false;
  late DateTime dateNow;
  late int buyerId;
  late int categoryId;
  late int accountId;
  // ignore: prefer_typing_uninitialized_variables
  var dateOut;
  DateTime? passingDate = DateTime.now();
  bool isSubmit = false;
  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd-MMMM-yy');
    dateOut = date.format(passingDate!);
    _dateController.text = dateOut;

    // getAllTransaction();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transaction',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      enabled: false,
                      controller: _dateController,
                      decoration: const InputDecoration(
                        hintText: 'Date Of Birth',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        passingDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365 * 100)),
                          lastDate: DateTime.now(),
                        );
                        if (passingDate == null) {
                          return;
                        }
                        final date = DateFormat('dd-MMMM-yy');
                        final dates = date.format(passingDate!);
                        _dateController.text = dates.toString();
                      },
                      icon: const Icon(Icons.calendar_today)),
                ],
              ),
              kHeight20,
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //     '0.00',
              //     style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _amountController,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (_) {
                    setState(() {
                      isSubmit = false;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Amount *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        transactionType = TransactionType.income;
                        transactionvalue = 'Income';
                        isSubmit = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      child: const Center(
                        child: Text('Income'),
                      ),
                      decoration: BoxDecoration(
                          color: transactionType == TransactionType.income
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        transactionType = TransactionType.expense;
                        transactionvalue = 'Expense';
                        isSubmit = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      child: const Center(
                        child: Text('Expense'),
                      ),
                      decoration: BoxDecoration(
                          color: transactionType == TransactionType.expense
                              ? Colors.red
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Category'),
              GetBuilder<SettingsController>(builder: (_) {
                return DropdownButton(
                  hint:
                      // _dropDownValueCategory.isEmpty
                      //     ? const Text('Select Category')
                      //     :
                      Text(
                    _dropDownValueCategory.isEmpty
                        ? _.categoryList[0].categoryName
                        : _dropDownValueCategory,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.blue),
                  items: _.categoryList.map(
                    (CategoryModel val) {
                      // print(categoryId);
                      return DropdownMenuItem<String>(
                        onTap: () {
                          categoryId = val.categoryId!;
                        },
                        value: _dropDownValueCategory.isEmpty
                            ? _.categoryList[0].categoryName
                            : val.categoryName,
                        child: Text(val.categoryName),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValueCategory = val.toString();
                      },
                    );
                  },
                );
              }),
              const SizedBox(
                height: 15,
              ),
              const Text('Account *'),
              GetBuilder<SettingsController>(builder: (_) {
                return DropdownButton(
                  hint: _dropDownValueAccount.isEmpty
                      ? const Text('Select Account')
                      : Text(
                          _dropDownValueAccount,
                          style: const TextStyle(color: Colors.blue),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.blue),
                  items: _.accountList.map(
                    (AccountModel val) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          accountId = val.accountId!;
                        },
                        value: val.accountName,
                        child: Text(val.accountName),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValueAccount = val.toString();
                        isSubmit = false;
                      },
                    );
                  },
                );
              }),
              const SizedBox(
                height: 15,
              ),
              const Text('Buyer'),
              GetBuilder<SettingsController>(builder: (_) {
                return DropdownButton(
                  hint:
                      // _dropDownValueBuyer.isEmpty
                      //     ? const Text('Select Buyer')
                      //     :
                      Text(
                    _dropDownValueBuyer.isEmpty
                        ? _.buyerList[0].buyerName
                        : _dropDownValueBuyer,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.blue),
                  items: _.buyerList.map(
                    (BuyersModel val) {
                      //print(buyerId);
                      return DropdownMenuItem(
                        onTap: () {
                          buyerId = val.buyerId!;
                        },
                        value: _dropDownValueBuyer.isEmpty
                            ? _.buyerList[0].buyerName
                            : val.buyerName,
                        child: Text(val.buyerName),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValueBuyer = val.toString();
                      },
                    );
                  },
                );
              }),
              const SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Status',
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 20),
                  ),
                  Switch(
                      value: isSwithed,
                      onChanged: (val) {
                        setState(() {
                          isSwithed = !isSwithed;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              IgnorePointer(
                ignoring: isSubmit,
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () {
                        // isSubmit = buttonSubmit();
                        buttonSubmit();
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Text('Create'),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> onAddButtonClicked() async {
    final amount = double.parse(_amountController.text);
    final description = _descriptionController.text;

    // final balance = _balanceController.text.trim();
    // if (name.isEmpty || balance.isEmpty) {
    //   return;
    // }

    if (_dropDownValueBuyer.isEmpty) {
      buyerId = Get.find<SettingsController>().buyerList[0].buyerId!;
    }

    if (_dropDownValueCategory.isEmpty) {
      categoryId = Get.find<SettingsController>().categoryList[0].categoryId!;
    }
    final data = TranscationModel(
        date: passingDate.toString(),
        amount: amount,
        type: transactionvalue,
        description: description,
        status: isSwithed.toString(),
        accountId: accountId,
        buyerId: buyerId,
        categoryId: categoryId);

    Get.find<HomeController>().addTransaction(data);
    Navigator.pop(context);
  }

  buttonSubmit() {
    if (_dropDownValueAccount.isEmpty ||
        _amountController.text.isEmpty ||
        transactionvalue.isEmpty) {
      setState(() {
        isSubmit = true;
      });
      Get.snackbar("Alert!!", "Please add Required Fields",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      return;
    } else if (_dropDownValueAccount.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        transactionvalue.isNotEmpty) {
      isSubmit = false;
      onAddButtonClicked();
    }
  }
}
