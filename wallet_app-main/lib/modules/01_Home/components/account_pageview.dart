// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallet_app/components/constants/constants.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class AccountPageView extends StatelessWidget {
  final _controller = PageController();
  AccountPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (Get.find<HomeController>().transactionLists.isNotEmpty) {
    //   Get.find<HomeController>().monthWiseCalculations(
    //       Get.find<SettingsController>().accountList[0].accountId!);
    // }
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
    return SizedBox(
      height: size.height * .27,
      child: GetBuilder<SettingsController>(builder: (setting) {
        return GetBuilder<HomeController>(builder: (_) {
          return setting.accountList.isEmpty
              ? Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 112, 140, 163),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Center(
                    child: Text(
                      ' Add Account Details',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      onPageChanged: (value) {
                        Get.find<HomeController>().monthWiseCalculations(
                            setting.accountList[value].accountId!);
                      },
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: setting.accountList.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        final data = setting.accountList[itemIndex];
                        // Get.find<HomeController>()
                        //     .calculateIncomeAndExpense(data.accountId!);

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 112, 140, 163),
                              borderRadius: BorderRadius.circular(25)),
                          height: 40,
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.accountName.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            letterSpacing: 1.2),
                                      ),
                                      const Icon(
                                        Icons.settings,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      const Text('Balance'),
                                      Text(
                                        "\₹${data.balance.toInt()}",
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                kHeight20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Monthly Income',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          '\₹${data.monthlyIncome}',
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 35,
                                        width: 2,
                                        child: ColoredBox(color: Colors.white)),
                                    Column(
                                      children: [
                                        const Text(
                                          'Monthly Expense',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "\₹${data.monthlyExpesne}",
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ]),
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: setting.accountList.length,
                            effect: const WormEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                dotColor: Colors.white,
                                activeDotColor: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  ],
                );
        });
      }),
    );
  }
}
