import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/components/constants/constants.dart';
import 'package:wallet_app/model/accounts.dart';
import 'package:wallet_app/model/category.dart';
import 'package:wallet_app/modules/02_Reports/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

import '../../../model/buyers.dart';

class FilteringPage extends StatefulWidget {
  const FilteringPage({Key? key}) : super(key: key);

  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  var _dropDownValueCategory = '';
  var _dropDownValueAccount = '';
  var _dropDownValueBuyer = '';
  late DateTime dateNow;
  int? buyerId;
  int? categoryId;
  int? accountId;
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? passingDate;
  DateTime? endingdate;
  bool isCategoryPressed = false;
  bool isAccountPressed = false;
  bool isBuyersPressed = false;
  List showfilterd = Get.find<ReportsController>().showfilterd;

  List<FilterData> filteringDatas = Get.find<ReportsController>().filteringdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Filters',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          kHeight40,
          const Text('Category'),
          GetBuilder<SettingsController>(builder: (_) {
            return DropdownButton(
              hint: _dropDownValueCategory.isEmpty
                  ? const Text('Select Category')
                  : Text(
                      _dropDownValueCategory,
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
                    value: val.categoryName,
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
          const Text('Account'),
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
              hint: _dropDownValueBuyer.isEmpty
                  ? const Text('Select Buyer')
                  : Text(
                      _dropDownValueBuyer,
                      style: const TextStyle(color: Colors.blue),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: const TextStyle(color: Colors.blue),
              items: _.buyerList.map(
                (BuyersModel val) {
                  return DropdownMenuItem(
                    onTap: () {
                      buyerId = val.buyerId!;
                    },
                    value: val.buyerName,
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
          kHeight20,
          const Text('Start Date'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 70,
                ),
                Flexible(
                    child: TextField(
                  controller: _startDateController,
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: "Enter date",
                    border: InputBorder.none,
                  ),
                )),
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
                      _startDateController.text = dates.toString();
                    },
                    icon: const Icon(Icons.calendar_today))
              ],
            ),
          ),
          kHeight10,
          const Text('End Date'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 70,
                ),
                Flexible(
                    child: TextField(
                  controller: _endDateController,
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: "Enter date",
                    border: InputBorder.none,
                  ),
                )),
                IconButton(
                    onPressed: () async {
                      endingdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 100)),
                        lastDate: DateTime.now(),
                      );
                      if (endingdate == null) {
                        return;
                      }
                      final date = DateFormat('dd-MMMM-yy');
                      final dates = date.format(endingdate!);
                      _endDateController.text = dates.toString();
                    },
                    icon: const Icon(Icons.calendar_today))
              ],
            ),
          ),
          kHeight40,
          MaterialButton(
              color: const Color.fromARGB(255, 112, 140, 163),
              onPressed: () {
                // List<TransactionList> data = [];
                // if (passingDate != null || Endingdate != null) {
                //   if (!showfilterd.contains(filteringDatas[3])) {
                //     showfilterd.add(filteringDatas[3]);
                //   }
                //   for (var list in Get.find<ReportsController>().dateFilter) {
                //     DateTime date1 = DateTime.parse(list.date);
                //     if (passingDate != null &&
                //         Endingdate != null &&
                //         date1.isAfter(passingDate!) &&
                //         date1.isBefore(Endingdate!)) {
                //       data.add(list);
                //     } else if (Endingdate == null &&
                //         date1.isAfter(passingDate!)) {
                //       data.add(list);
                //     } else if (passingDate == null &&
                //         date1.isBefore(Endingdate!)) {
                //       data.add(list);
                //     }
//  if (passingDate == null && Endingdate != null) {
//                       if (date1.isAfter(passingDate!)) {
//                         data.add(list);
//                       }
//                     }
//                     if (date1.isBefore(Endingdate!) && passingDate == null) {
//                       data.add(list);
//                     }
                //   }
                //   Get.find<ReportsController>().dateFilter = data;
                // }

                // if (buyerId != null) {
                // if (!showfilterd.contains(filteringDatas[1])) {
                //   showfilterd.add(filteringDatas[1]);
                // }

                // Get.find<ReportsController>().filterByBuyers(buyerId!);
                // } else {
                //   filteringDatas.remove(FilterData(
                //       filterType: 'Buyer', filterName: _dropDownValueBuyer));
                // }
                // if (accountId != null) {
                // if (!showfilterd.contains(filteringDatas[2])) {
                //   showfilterd.add(filteringDatas[2]);
                // }
                //   filteringDatas.add(FilterData(
                //       filterType: 'Account',
                //       filterName: _dropDownValueAccount));

                //   // Get.find<ReportsController>().filterByAccount(accountId!);
                // } else {
                //   filteringDatas.add(FilterData(
                //       filterType: 'Account',
                //       filterName: _dropDownValueAccount));
                // }
                // if (categoryId != null) {
                // if (!showfilterd.contains(filteringDatas[0])) {
                //   showfilterd.add(filteringDatas[0]);
                // }

                // filteringDatas.add(FilterData(
                //     filterType: 'Category',
                //     filterName: _dropDownValueCategory));
                // Get.find<ReportsController>().filterByCategory(categoryId!);

                // } else {
                //   filteringDatas.add(FilterData(
                //       filterType: 'Category',
                //       filterName: _dropDownValueCategory));
                // }

                Get.find<ReportsController>().filters(
                    accountId,
                    buyerId,
                    categoryId,
                    passingDate,
                    endingdate,
                    _dropDownValueAccount,
                    _dropDownValueBuyer,
                    _dropDownValueCategory);

                Get.find<ReportsController>().update();

                Get.back();
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
