import 'package:flutter/material.dart';
import 'package:environment_app/view_models/Env_inc_view_model.dart';

class EnvIncList extends StatelessWidget {
  final List<EnvIncViewModel> envIncidents;
  EnvIncList({required this.envIncidents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: envIncidents.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(envIncidents[index].title),
          );
        }
    );
  }
}
