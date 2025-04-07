import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/modelsUI/modelTask.dart';
import 'package:training_proj/widgets/app_text.dart';
import '../providers/brightness_provider.dart';
import '../providers/task_simple_provider.dart';

class GestionTaches extends StatelessWidget {
  GestionTaches({super.key});

  final TextEditingController taskController = TextEditingController();
  //List<Widget> taskWidget = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        // retour sur homePage
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.red,),
        ),

        title: AppText(text: "Gestion des tâches simples"),

        actions: [
          // Changer de thème
          Consumer<BrightnessProvider>(builder: (context, brightnessProvider, child){
            return IconButton(
              onPressed: brightnessProvider.changeTheme,
              icon: Icon(brightnessProvider.brightness == Brightness.light ? Icons.dark_mode : Icons.light_mode,),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskProvider.taskList.length,
                    itemBuilder: (context, index){
                      return ModelTask(title: taskProvider.taskList[index], index: index,);
                    },
                  );
                },
              ),
            ),

            // Formulaire d'ajout

            Consumer<TaskProvider> (builder: (context, taskProvider, child){
              return TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "Entrez le nom de la tâche",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )
                  ),
                  // ajout de tâche
                  suffixIcon: IconButton(
                    onPressed: (){taskProvider.addTask(taskController.text); taskController.clear();},
                    icon: Icon(Icons.add, color: Colors.green,),
                  ),
                ),
              );
            },),
          ],
        ),
      ),
    );
  }
}

