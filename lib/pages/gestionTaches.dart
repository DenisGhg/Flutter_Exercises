import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/modelsUI/modelTask.dart';
// Etat task
class TaskProvider with ChangeNotifier{
  List<String> taskList = [];

  void addTask(String task){
    if(task.isNotEmpty){
      taskList.add(task);
      notifyListeners();
    }
  }

  void removeTask(int index){
    taskList.removeAt(index);
    notifyListeners();
  }
}

// Etat theme
class BrightnessProvider with ChangeNotifier{
  Brightness brightness = Brightness.light;

  void changeTheme(){
    brightness = (brightness == Brightness.light) ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}

//
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
          icon: Icon(Icons.arrow_back_rounded, color: Colors.blue,),
        ),

        title: Text("Gestion de Tâche et changement de thème", style: TextStyle(fontSize: 11),),

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
                      return ModelTask(taskName: taskProvider.taskList[index], index: index,);
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

