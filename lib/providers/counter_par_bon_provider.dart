import 'package:flutter/material.dart';

class CounterBonProvider with ChangeNotifier{
  int counter = 0;
  //int bon = 0;

  /*void enterBon(int value){
    bon = value;
    notifyListeners();
  }*/

  void increment(int pas){
    counter += pas;
    notifyListeners();
  }

  void decrement(int pas){
    counter -= pas;
    notifyListeners();
  }

}
