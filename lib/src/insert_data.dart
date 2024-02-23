// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_with_mysql/src/database/data.dart';
import 'package:flutter_with_mysql/src/show_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Mysql();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // method to insert data in mySQL
  void insertData() async {
    db.getConnection().then((conn) {
      String sqlQuery = 'insert into users (email, password) values (?, ?)';
      conn.query(
        sqlQuery,
        [emailController.text, passwordController.text],
      );
      setState(() {});
      print("Data Added");
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter with MySQL'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "password"),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              insertData();
              print('Data Inserted Successfully');
            },
            child: const Text(
              'Insert Data',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SQLData(),
                ),
              );
              setState(() {});
            },
            child: const Text('Show Data'),
          )
        ],
      ),
    );
  }
}
