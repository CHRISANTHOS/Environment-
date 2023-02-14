import 'package:environment_app/services/web_services.dart';
import 'package:environment_app/view_models/Env_inc_view_model.dart';
import 'package:flutter/material.dart';

class EnvListViewModel extends ChangeNotifier {

  List<EnvIncViewModel> envIncidents = [];

  Future<void> getAllIncidents()async{
    final results = await WebService().getAllEnvIncidents();
    envIncidents = results.map((envIncident) => EnvIncViewModel(envIncidents: envIncident)).toList();
    notifyListeners();
  }

}