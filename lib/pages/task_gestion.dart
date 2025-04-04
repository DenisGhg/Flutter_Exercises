import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/modelsUI/task_item.dart';

import '../models/task.dart';

class TaskGestion extends StatelessWidget {
  TaskGestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Center(child: Text("Liste de tâches"))),
      body: ListView.builder(
        itemCount: context.watch<TasksProvider>().tasks.length,
        itemBuilder: (context, index){
          return context.watch<TasksProvider>().tasks[index];
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (bottomSheetContext) {

              final _titleController = TextEditingController();
              final _descriptionController = TextEditingController();
              String _emptyFieldError = "";

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ Remonte avec le clavier
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("Créez un tache"),

                        // Message d'erreur si le formulaire de tâche vide
                        Text(_emptyFieldError, style: TextStyle(color: Colors.red),),
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(hintText: 'Titre'),
                        ),
                        TextField(
                          controller: _descriptionController,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(hintText: 'Description'),
                        ),
                        
                        SizedBox(
                          height: 10,
                        ),
                        // Bouton validé

                        InkWell(
                          onTap: (){
                            context.read<TasksProvider>().addTask(TaskItem(task: Task(_titleController.text, _descriptionController.text),));

                            if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
                              _titleController.clear();
                              _descriptionController.clear();
                              Navigator.pop(bottomSheetContext);
                            }else{
                              _emptyFieldError = "Veuillez remplir tous les champs";
                            }

                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Ajouter la tâche",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TasksProvider with ChangeNotifier{
  List<TaskItem> _tasks = [];
  List<TaskItem> get tasks => _tasks;

  void addTask(TaskItem taskProvider){
    if(taskProvider.task.title.isNotEmpty && taskProvider.task.description.isNotEmpty){
      int newId = _tasks.isNotEmpty ? _tasks.last.task.id + 1 : 0;
      taskProvider.task.id = newId;
      _tasks.add(taskProvider);
    }
    notifyListeners();
  }

  void removeTask(int id){
    List<TaskItem> newTask = [];
    for (var task in _tasks){
      if(task.task.id != id){
        newTask.add(task);
      }
    }
    _tasks = newTask;
    notifyListeners();
  }

  void updateTask(int id, String newTitle, String newDescription){
    if(id >= 0 && id < _tasks.length){
      _tasks[id] = TaskItem(task: Task(newTitle, newDescription, id: id));
    }
    notifyListeners();
  }

}