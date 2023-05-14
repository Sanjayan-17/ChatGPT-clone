import 'package:chat_gpt_clone/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import '../models/chat_model.dart';

class chatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageandGetAnswers(
      {required String msg, required String choosenModelId}) async {
    chatList.addAll(
        await ApiService.sendMessage(message: msg, modelId: choosenModelId));
    notifyListeners();
  }
}
