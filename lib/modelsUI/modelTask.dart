import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_simple_provider.dart';

class ModelTask extends StatelessWidget {

  final String title;
  final int index;
  ModelTask({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider> (builder : (context, taskProvider, child){
      return ListTile(
        title: Text(title),
        trailing: IconButton(
            onPressed: (){taskProvider.removeTask(index);},
            icon: Icon(Icons.delete_forever, color: Colors.red,)),
      );
    });

  }
}
