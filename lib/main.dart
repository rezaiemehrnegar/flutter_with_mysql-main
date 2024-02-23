import 'package:flutter/material.dart';
import 'package:flutter_with_mysql/src/insert_data.dart';

void main() {
  runApp(const FlutterWithMySQL());
}

class FlutterWithMySQL extends StatelessWidget {
  const FlutterWithMySQL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter with MySQL',
      home: HomePage(),
    );
  }
}
