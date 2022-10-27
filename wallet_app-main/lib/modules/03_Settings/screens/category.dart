import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/components/constants/constants.dart';
import 'package:wallet_app/components/header_text.dart';
import 'package:wallet_app/model/category.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class Category extends StatelessWidget {
  final _categoryController = TextEditingController();

  Category({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<SettingsController>().getAllCategories();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight20,
          const HeaderText(heading: 'Add Categories'),
          kHeight20,
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              labelText: "Add a Category",
            ),
          ),
          kHeight20,
          ElevatedButton(
              onPressed: () {
                onButtonClicked();
                FocusScope.of(context).unfocus();
              },
              child: const Text('Add Category')),
          Expanded(
            child: GetBuilder<SettingsController>(builder: (_) {
              final category = _.categoryList.toList();
              if (category.isNotEmpty) {
                category.removeAt(0);
              }

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2 / 1.1,
                  ),
                  itemCount: category.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Chip(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 174, 227, 175),
                      label: Text(category[index].categoryName),
                      avatar: const Icon(
                        Icons.category,
                        size: 12,
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }

  onButtonClicked() async {
    final category = _categoryController.text;
    if (category.isEmpty) {
      return;
    }
    final data = CategoryModel(
      categoryName: category,
    );

    Get.find<SettingsController>().addCategories(data);
    _categoryController.clear();
  }
}
