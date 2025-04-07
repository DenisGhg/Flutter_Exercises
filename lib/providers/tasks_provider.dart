import 'package:flutter/material.dart';
import 'package:training_proj/modelsUI/task_item.dart';

import '../models/task.dart';

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