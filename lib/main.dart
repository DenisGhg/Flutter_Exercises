import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/counter_page.dart';
import 'package:training_proj/pages/counter_par_bon_page.dart';
import 'package:training_proj/pages/gestionTaches.dart';
import 'package:training_proj/pages/homePage.dart';
import 'package:training_proj/pages/query_laucher_page.dart';
import 'package:training_proj/pages/task_gestion.dart';
import 'package:training_proj/pages/user_profile_with_random_user_api.dart';
import 'package:training_proj/providers/brightness_provider.dart';
import 'package:training_proj/providers/counter_par_bon_provider.dart';
import 'package:training_proj/providers/counter_provider.dart';
import 'package:training_proj/providers/task_simple_provider.dart';
import 'package:training_proj/providers/tasks_provider.dart';

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

        // Compteur avec bon
        ChangeNotifierProvider(create: (BuildContext context) => CounterBonProvider()),
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
        initialRoute: '/',
        routes: {
          '/' : (context) => HomePage(),
          '/counter' : (context) => CounterPage(),
          '/counterParBon' : (context) => CounterParBonPage(),
          '/gestionTacheSimples' : (context) => GestionTaches(),
          '/gestionTachesAvancees' : (context) => TaskGestion(),
          '/userProfilWithRandomUserAPI' : (context) => UserProfileWithRandomUserApi(),
          '/queryLauncherPage' : (context) => QueryLauncherPage()
        },
      );
    });
  }
}
