import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String heading;

  const HeaderText({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}
