import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/gestionTaches.dart';

class ModelTask extends StatelessWidget {

  String taskName = "";
  final int index;
  ModelTask({super.key, required this.taskName, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider> (builder : (context, taskProvider, child){
      return ListTile(
        title: Text(taskName),
        trailing: IconButton(
            onPressed: (){taskProvider.removeTask(index);},
            icon: Icon(Icons.delete_forever, color: Colors.red,)),
      );
    });

  }
}
