// import 'dart:js';

import 'dart:developer';

import 'package:chat_gpt_clone/constants/constants.dart';
import 'package:chat_gpt_clone/models/chat_model.dart';
import 'package:chat_gpt_clone/providers/models_provider.dart';
import 'package:chat_gpt_clone/services/api_services.dart';
import 'package:chat_gpt_clone/services/assets_manager.dart';
import 'package:chat_gpt_clone/widgets/chat_widgets.dart';
import 'package:chat_gpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:chat_gpt_clone/providers/chat_providers.dart';
import '../services/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = true;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];
  Widget build(BuildContext context) {
    String? currentModels;
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final ChatProvider = Provider.of<chatProvider>(context, listen: false);
    currentModels = modelsProvider.getcurrentModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.Logo),
        ),
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
                // await showModalBottomSheet(
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(
                //       top: Radius.circular(20),
                //     )
                //   ),
                //     context: context,
                //     builder: (context) {
                //       return Padding(
                //         padding: const EdgeInsets.all(18.0),
                //         child: Row(children: const [
                //           Flexible(
                //             child: TextWidget(
                //             label: "Choose your Model",
                //             fontSize: 16)
                //           ),
                //         ],
                //         ),
                //       );
                //     });
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: ChatProvider.getChatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: ChatProvider
                          .getChatList[index].msg, //chatList[index].msg,
                      chatIndex: ChatProvider.getChatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value) async {
                        await sendMessageFCT(
                            modelsProvider: modelsProvider,
                            ChatProvider: ChatProvider);
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "How can i Help you today",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await sendMessageFCT(
                            modelsProvider: modelsProvider,
                            ChatProvider: ChatProvider);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required chatProvider ChatProvider}) async {
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        ChatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await ChatProvider.sendMessageandGetAnswers(
          msg: textEditingController.text,
          choosenModelId: modelsProvider.getcurrentModel);
      // chatList.addAll(await ApiService.sendMessage(
      //     message: textEditingController.text,
      //     modelId: modelsProvider.getcurrentModel));
      setState(() {});
    } catch (e) {
      log("error $e");
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
