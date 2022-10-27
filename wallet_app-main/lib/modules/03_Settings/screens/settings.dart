import 'package:flutter/material.dart';
import 'package:wallet_app/modules/03_Settings/screens/account.dart';
import 'package:wallet_app/modules/03_Settings/screens/buyers.dart';
import 'package:wallet_app/modules/03_Settings/screens/category.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          // ignore: prefer_const_constructors
          backgroundColor: Color.fromARGB(255, 112, 140, 163),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Account",
              icon: Icon(
                Icons.account_balance,
                color: Colors.black,
              ),
            ),
            Tab(
              text: "Category",
              icon: Icon(Icons.category, color: Colors.black),
            ),
            Tab(
              text: "Buyers",
              icon: Icon(Icons.event_busy_rounded, color: Colors.black),
            ),
          ]),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Account(),
              Category(),
              Buyers(),
            ]),
      ),
    );
  }
}
