import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:wallet_app/db/functions/db_function.dart';
import 'package:wallet_app/routes/app_pages.dart';
import 'package:wallet_app/routes/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.HOME,
      getPages: AppPages.routes,
      initialBinding: HomeBinging(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainHomeScreen(
//         defaultMenuIndex: 0,
//       ),
//     );
//   }
// }
