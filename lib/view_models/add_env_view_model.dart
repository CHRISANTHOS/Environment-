import 'package:environment_app/model/Env-incident.dart';
import 'package:environment_app/services/web_services.dart';

class AddEnvViewModel{

  String? title;
  String? description;
  String? imagePath;

  Future<void> saveIncident()async{
    final incident = EnvIncidents(title: title!, description: description!, imagePath: imagePath!);
    await WebService().saveIncident(incident);
  }
}