import 'package:flutter/material.dart';
import 'add_environment.dart';

class EnvironmentScreen extends StatefulWidget {
  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: Text('EnvHub'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Refresh"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Log Out"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              //TODO: ADD REFRESH CODE
            } else if (value == 1) {
              //TODO: ADD LOGOUT CODE
            }
          }),
        ],
      ),
      body: Text('EnvHub'),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => AddEnvScreen()
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
