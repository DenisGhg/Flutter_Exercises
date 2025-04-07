import 'package:flutter/material.dart';

class BrightnessProvider with ChangeNotifier{
  Brightness brightness = Brightness.light;

  void changeTheme(){
    brightness = (brightness == Brightness.light) ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}
