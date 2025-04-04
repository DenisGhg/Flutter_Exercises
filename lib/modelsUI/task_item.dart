import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/task_gestion.dart';

import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: (){
              context.read<TasksProvider>().removeTask(task.id); // Suppression de la tâche
            },
            icon: Icon(Icons.delete, color: Colors.red,),
          ),
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (sheetContext){
                  final _titleController = TextEditingController(text: task.title);
                  final _descriptionController = TextEditingController(text: task.description);
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ Remonte avec le clavier
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(sheetContext).size.height * 0.3,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Modifier la tâche"),
                      
                              // Message d'erreur si le formulaire de tâche vide
                              //Text(_emptyFieldError, style: TextStyle(color: Colors.red),),
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
                                  //context.read<TasksProvider>().addTask(TaskItem(task: Task(_titleController.text, _descriptionController.text),));
                                  if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
                                    context.read<TasksProvider>().updateTask(task.id, _titleController.text, _descriptionController.text);
                                    _titleController.clear();
                                    _descriptionController.clear();
                                    Navigator.pop(sheetContext);
                                  }/*else{
                                    _emptyFieldError = "Veuillez remplir tous les champs";
                                  }*/
                      
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
                                      "Modifier la tâche",
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
                    ),
                  );
                }
              );
            },
            icon: Icon(Icons.edit, color: Colors.green,),
          ),
        ],
      ),
    );
  }
}
