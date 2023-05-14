import 'package:chat_gpt_clone/models/models_model.dart';
import 'package:chat_gpt_clone/services/api_services.dart';
import 'package:flutter/cupertino.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> modelsList = [];
  String currentModel = "text-davinci-003";
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  String get getcurrentModel {
    return currentModel;
  }
  
  // // Future<List<ModelsModel>> getAllModels ()async{
  //    modelsList = await ApiService.getModels();
  //    return modelsList;
  // }
  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }
   Future<List<ModelsModel>> getAllModels ()async{
     modelsList = await ApiService.getModels();
     return modelsList;
  }
}
