import 'dart:convert';
import 'dart:developer';

import 'package:chat_gpt_clone/constants/api_consts.dart';
import 'package:chat_gpt_clone/models/chat_model.dart';
import 'package:chat_gpt_clone/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
        },
      );

      Map jsonResponse = jsonDecode(response.body);
      print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-type': 'application/json',
          },
          body: jsonEncode({
            "model": modelId,
            "prompt": message,
            "temperature": 0,
            "max_tokens": 1000
          }));
      Map jsonResponse = jsonDecode(response.body);
      List<ChatModel> chatList = [];
      print("jsonResponse $jsonResponse");
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                msg: jsonResponse["choices"][index]["text"], chatIndex: 1));
      }
      return chatList;
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }
}
