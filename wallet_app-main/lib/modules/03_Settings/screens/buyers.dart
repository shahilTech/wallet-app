import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/components/constants/constants.dart';
import 'package:wallet_app/components/header_text.dart';

import 'package:wallet_app/model/buyers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class Buyers extends StatelessWidget {
  final _buyerController = TextEditingController();

  Buyers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<SettingsController>().getAllBuyers();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight20,
          const HeaderText(heading: 'Add Buyers List'),
          kHeight20,
          TextField(
            controller: _buyerController,
            decoration: const InputDecoration(labelText: "Add a Buyer Name"),
          ),
          kHeight20,
          ElevatedButton(
              onPressed: () {
                onButtonClicked();
                FocusScope.of(context).unfocus();
              },
              child: const Text('Add Buyer')),
          Expanded(
            child: GetBuilder<SettingsController>(builder: (_) {
              final buyerList = _.buyerList.toList();
              if (buyerList.isNotEmpty) {
                buyerList.removeAt(0);
              }

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2 / 1.1,
                  ),
                  itemCount: buyerList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final data = buyerList[index];
                    return Chip(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 174, 227, 175),
                      label: Text(data.buyerName),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }

  onButtonClicked() {
    final buyer = _buyerController.text;
    if (buyer.isEmpty) {
      return;
    }
    final data = BuyersModel(
      buyerName: buyer,
    );
    Get.find<SettingsController>().addBuyers(data);
    _buyerController.clear();
  }
}
