import 'package:flutter/material.dart';
import 'add_environment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:environment_app/view_models/Env_inc_list_view_model.dart';
import 'package:environment_app/widgets/env_inc_list.dart';
import 'package:environment_app/view_models/add_env_view_model.dart';

class EnvironmentScreen extends StatefulWidget {
  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EnvListViewModel>(context);


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: const Text('EnvHub'),
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
              _auth.signOut();
              Navigator.pop(context);
            }
          }),
        ],
      ),
      body: EnvIncList(envIncidents: vm.envIncidents),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => ChangeNotifierProvider(create: (BuildContext context) => AddEnvViewModel(),
            child: AddEnvScreen())
          );
        },
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),
      ),
    );
  }
}
