import 'package:flutter/material.dart';
import 'package:flutter_with_mysql/src/database/data.dart';
import 'package:flutter_with_mysql/src/model/model.dart';

class SQLData extends StatefulWidget {
  const SQLData({
    Key? key,
  }) : super(key: key);

  @override
  State<SQLData> createState() => _SQLDataState();
}

class _SQLDataState extends State<SQLData> {
// method to display MySQL Data

  Future<List<Profiles>> getSQLData() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'select email, password from users';
      await conn.query(sqlQuery).then((results) {
        for (var res in results) {
          final profileModel =
              Profiles(email: res["email"], password: res["password"]);

          profileList.add(profileModel);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });

    return profileList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getDBData(),
      ),
    );
  }

  FutureBuilder<List<Profiles>> getDBData() {
    return FutureBuilder<List<Profiles>>(
        future: getSQLData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data as List<Profiles>;
                return ListTile(
                  title: Text(
                    data[index].email.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data[index].password.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              });
        });
  }
}
