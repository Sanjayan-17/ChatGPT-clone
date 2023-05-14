import 'package:chat_gpt_clone/constants/constants.dart';
import 'package:chat_gpt_clone/models/models_model.dart';
import 'package:chat_gpt_clone/providers/models_provider.dart';
import 'package:chat_gpt_clone/services/api_services.dart';
import 'package:chat_gpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class drop_down extends StatefulWidget {
  const drop_down({super.key});

  @override
  State<drop_down> createState() => _drop_downState();
}

class _drop_downState extends State<drop_down> {
  @override
  Widget build(BuildContext context) {
    String? currentModels;
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModels = modelsProvider.getcurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: scaffoldBackgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                              value: snapshot.data![index].id,
                              child: TextWidget(
                                label: snapshot.data![index].id,
                                fontSize: 15,
                              ),
                            )),
                    value: currentModels,
                    onChanged: (value) => {
                      setState(() {
                        currentModels = value.toString();
                      }),
                      modelsProvider.setCurrentModel(value.toString()),
                    },
                  ),
                );
        });

    // DropdownButton(
    //   dropdownColor: scaffoldBackgroundColor,
    //   iconEnabledColor: Colors.white,
    //   items: getModelsItem,
    //   value: currentModels,
    //   onChanged: (value) => {setState(() {
    //     currentModels = value.toString();
    //   })

    //   },
    // );
  }
}
