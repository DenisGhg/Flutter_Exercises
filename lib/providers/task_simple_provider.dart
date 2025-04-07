import 'package:flutter/material.dart';

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