import 'package:environment_app/model/Env-incident.dart';

class EnvIncViewModel {

  EnvIncidents envIncidents;

  EnvIncViewModel({required this.envIncidents});

  String get title{
    return envIncidents.title;
  }

  String get description{
    return envIncidents.description;
  }

  String get imagePath{
    return envIncidents.imagePath;
  }
}