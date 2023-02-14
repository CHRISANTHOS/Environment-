import 'package:dio/dio.dart';
import 'package:environment_app/model/Env-incident.dart';

class WebService {

  Future<void> saveIncident (EnvIncidents envIncidents)async{


  }

  Future<List<EnvIncidents>> getAllEnvIncidents()async{

    final url = '<API URL>';

    final response = await Dio().get(url);
    if(response.statusCode == 200){
      Iterable json = response.data;
      return  json.map((incident) => EnvIncidents.fromJson(incident)).toList();
    }else{
      throw Exception('Can\'t get EnvIncidents');
    }

  }

}