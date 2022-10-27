// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/routes/app_pages.dart';

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.toNamed(AppPages.HOME);
          },
          child: const Text('go to login'),
        ),
      ),
    );
  }
}
