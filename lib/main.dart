import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/gestionTaches.dart';
import 'package:training_proj/pages/homePage.dart';
import 'package:training_proj/pages/task_gestion.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [

        //Counter
        ChangeNotifierProvider(create: (BuildContext context) => CounterProvider()),

        // Liste de tâche
        ChangeNotifierProvider(create: (BuildContext context) => TaskProvider()),

        // Theme
        ChangeNotifierProvider(create: (BuildContext context) => BrightnessProvider()),

        // Gestion de tâches avancée
        ChangeNotifierProvider(create: (BuildContext context) => TasksProvider()),
      ],
      child: const MyApp(),
    ),


  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<BrightnessProvider>(builder: (context, brightnessProvider, child){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: brightnessProvider.brightness,),

        ),
        debugShowCheckedModeBanner: false,
        home: TaskGestion(),
      );
    });
  }
}
