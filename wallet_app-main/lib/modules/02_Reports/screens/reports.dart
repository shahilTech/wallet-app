import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/components/constants/constants.dart';

import 'package:wallet_app/modules/02_Reports/controllers/state_controllers.dart';
import 'package:wallet_app/modules/02_Reports/screens/filtering_page.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String selectedValue = '';
  bool isCategoryPressed = false;
  bool isAccountPressed = false;
  bool isBuyersPressed = false;
  RxBool isPressed = false.obs;

  // filteredData() {
  //   showfilterd.clear();
  //   setState(() {
  //     if (isCategoryPressed == true) {
  //       showfilterd.insert(0, "Category");
  //     } else {
  //       showfilterd.remove("Category");
  //     }
  //     if (isBuyersPressed == true) {
  //       showfilterd.insert(0, "Buyers");
  //     } else {
  //       showfilterd.remove("Buyers");
  //     }
  //     if (isAccountPressed == true) {
  //       showfilterd.insert(0, "Account");
  //     } else {
  //       showfilterd.remove("Account");
  //     }

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Get.find<ReportsController>().listFilters();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  isPressed.value = !isPressed.value;
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Obx(
              () => isPressed.value == true
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          Get.find<ReportsController>().filterBySearch(value);
                        },
                        decoration: const InputDecoration(
                          isDense: true, contentPadding: EdgeInsets.all(8), //
                        ),
                      ))
                  : const SizedBox(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                  color: const Color.fromARGB(255, 112, 140, 163),
                  onPressed: () {
                    Get.to(() => const FilteringPage());
                  },
                  child: const Text('filter')),
            ),
            Get.find<ReportsController>().filteringdata.isEmpty
                ? const SizedBox()
                : Flexible(
                    flex: 1,
                    child: GetBuilder<ReportsController>(builder: (_) {
                      return GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            childAspectRatio: 2 / .5,
                          ),
                          itemCount: Get.find<ReportsController>()
                              .filteringdata
                              .length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Wrap(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 5.0, 5.0, 5.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffDBDBDB),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runSpacing: 10,
                                    children: <Widget>[
                                      // Padding(padding: const EdgeInsets.all(5.0)),
                                      FittedBox(
                                        child: Text(
                                          Get.find<ReportsController>()
                                              .filteringdata[index]
                                              .filterName
                                              .toString(),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(5.0)),
                                      InkWell(
                                        onTap: () {
                                          Get.find<ReportsController>()
                                              .filteringdata
                                              .removeAt(index);
                                          Get.find<ReportsController>()
                                              .update();
                                          if (Get.find<ReportsController>()
                                              .filteringdata
                                              .isEmpty) {
                                            Get.find<ReportsController>()
                                                .listFilters();
                                          }
                                        },
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    }),
                  ),
            Flexible(
              flex: 5,
              child: GetBuilder<ReportsController>(builder: (_) {
                return _.filteredList.isEmpty
                    ? const Center(
                        child: Text('No Reports'),
                      )
                    : ListView.builder(
                        primary: true,
                        reverse: false,
                        itemBuilder: (context, index) {
                          final data = _.filteredList[index];
                          // final date1 = DateTime.parse(data.date);
                          // if (date1.isAfter(passingDate!) &&
                          //     date1.isBefore(Endingdate!)) {}
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
                        itemCount: _.filteredList.length,
                      );
              }),
            )
          ],
        ),
      )),
    );
  }
}

// Row(
//   children: [
//     PopupMenuButton(
//         onSelected: (value) {
//           print(value);
//         },
//         color: Color.fromARGB(255, 112, 140, 163),
//         child: Container(
//           height: 25,
//           width: 40,
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(.2),
//               borderRadius: BorderRadius.circular(20)),
//           child: Center(
//               child: Text(
//             'filter',
//             style: TextStyle(color: Colors.black),
//           )),
//         ),
//         itemBuilder: (context) => [
//               PopupMenuItem(
//                 onTap: () {
//                   setState(() {
//                     isCategoryPressed = !isCategoryPressed;
//                   });
//                 },
//                 child: Row(
//                   children: [
//                     Text("Category"),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isCategoryPressed = false;
//                           });
//                         },
//                         icon: isCategoryPressed
//                             ? Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               )
//                             : SizedBox())
//                   ],
//                 ),
//                 value: 1,
//               ),
//               PopupMenuItem(
//                 onTap: () {
//                   setState(() {
//                     isAccountPressed = !isAccountPressed;
//                   });
//                 },
//                 child: Row(
//                   children: [
//                     Text("Account"),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isAccountPressed = false;
//                           });
//                         },
//                         icon: isAccountPressed
//                             ? Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               )
//                             : SizedBox())
//                   ],
//                 ),
//                 value: 2,
//               ),
//               PopupMenuItem(
//                 onTap: () {
//                   setState(() {
//                     isBuyersPressed = !isBuyersPressed;
//                   });
//                 },
//                 child: Row(
//                   children: [
//                     Text("Buyer"),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isBuyersPressed = false;
//                           });
//                         },
//                         icon: isBuyersPressed
//                             ? Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               )
//                             : SizedBox())
//                   ],
//                 ),
//                 value: 3,
//               )
//             ]),
//     kWidth40
//   ],
// )

// filterdialog(BuildContext context, showFiltered) {

//     showDialog<void>(
//       barrierDismissible: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.grey,
//                 ),
//                 height: 320,
//                 width: 230,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Column(
//                     children: [
//                       kHeight10,
//                       const Text(
//                         'Filter',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                       kHeight10,
//                       Row(
//                         children: [
//                           Container(
//                             child: Material(
//                                 color: Colors.grey,
//                                 child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         isCategoryPressed = !isCategoryPressed;
//                                         if (showfilterd
//                                             .contains(filteringDatas[0])) {
//                                           showfilterd.remove(filteringDatas[0]);
//                                         } else {
//                                           showfilterd.add(filteringDatas[0]);
//                                         }
//                                       });
//                                     },
//                                     child: const Text(
//                                       'Category',
//                                       style: TextStyle(fontSize: 20),
//                                     ))),
//                           ),
//                           kWidth20,
//                           isCategoryPressed ? Icon(Icons.close) : SizedBox()
//                           // IconButton(onPressed: () {}, icon: Icon(Icons.close))
//                         ],
//                       ),
//                       kHeight10,
//                       Row(
//                         children: [
//                           Material(
//                             color: Colors.grey,
//                             child: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   isAccountPressed = !isAccountPressed;
//                                   if (showfilterd.contains(filteringDatas[2])) {
//                                     showfilterd.remove(filteringDatas[2]);
//                                   } else {
//                                     showfilterd.add(filteringDatas[2]);
//                                   }
//                                 });
//                               },
//                               child: const Text(
//                                 'Account ',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ),
//                           ),
//                           kWidth20,
//                           isAccountPressed ? Icon(Icons.close) : SizedBox()
//                         ],
//                       ),
//                       kHeight10,
//                       Row(
//                         children: [
//                           Material(
//                               color: Colors.grey,
//                               child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       isBuyersPressed = !isBuyersPressed;
//                                       if (showfilterd
//                                           .contains(filteringDatas[1])) {
//                                         showfilterd.remove(filteringDatas[1]);
//                                       } else {
//                                         showfilterd.add(filteringDatas[1]);
//                                       }
//                                     });
//                                   },
//                                   child: Container(
//                                       child: const Text(
//                                     'Buyer      ',
//                                     style: TextStyle(fontSize: 20),
//                                   )))),
//                           kWidth20,
//                           isBuyersPressed ? Icon(Icons.close) : SizedBox()
//                         ],
//                       ),
//                       kHeight10,

//                       kHeight30,
//                       Material(
//                           color: Colors.grey,
//                           child: ElevatedButton(
//                               onPressed: () {

//                               },
//                               child: const Text('apply')))
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
