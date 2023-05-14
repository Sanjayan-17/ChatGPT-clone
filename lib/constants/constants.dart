import 'package:chat_gpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);

// List<String> models = [
//   "Model1",
//   "Model2",
//   "Model3",
//   "Model4",
//   "Model5",
//   "Model6",
// ];

// List<DropdownMenuItem<String>> get getModelsItem {
//   List<DropdownMenuItem<String>> modelsItem =
//       List<DropdownMenuItem<String>>.generate(
//           models.length,
//           (index) => DropdownMenuItem(
//                 value: models[index],
//                 child: TextWidget(
//                   label: models[index],
//                   fontSize: 15,
//                 ),
//               ));

//   return modelsItem;
// }

final chatMessages = [
  {
    "msg": "Hello who are you?",
    "chatIndex": 0,
  },
  {
    "msg":
        "ChatGPT (Chat Generative Pre-trained Transformer[2]) is a chatbot developed by OpenAI and launched in November 2022. It is built on top of OpenAIs GPT-3 family of large language models and has been fine-tuned (an approach to transfer learning) using both supervised and reinforcement learning techniques.ChatGPT was launched as a prototype on November 30, 2022, and quickly garnered attention for its detailed responses and articulate answers across many domains of knowledge. Its uneven factual accuracy, however, has been identified as a significant drawback.[3] Following the release of ChatGPT, OpenAIs valuation was estimated at US29 billion in 2023.[4] ",
    "chatIndex": 1
  },
  {
    "msg": "Tell something about me",
    "chatIndex": 0,
  },
  {
    "msg":
        "You are Sanjayan dafijrowsdhfveruhdfciuerhbaoduhcewausodhewouadgbceiyawdfbcierbdfivybano;fcherodsifnceriudjhcnleiufdhfbuerhfbdvhiuadsbv hjfdbvibfdcvebdifcgedyfcbweudsfbcedbfcuhbeduchebduhcbeduvbuyfdbvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvdfyvefybdybfduyvbuyfdbuvycefdvbcyusvdfbuycebduycedvcyeudvvvvvvvvvvvvvvvvvucyfvuysvycf",
    "chatIndex": 1,
  },
];
