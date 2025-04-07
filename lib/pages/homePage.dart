import 'package:flutter/material.dart';
import 'package:training_proj/widgets/app_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> exerciceTitles = [
    "Counter Simple",
    "Counter par bon",
    "Gestion des tâches simples",
    "Gestion des tâches avancées",
  ];

  final List<String> exerciceDescriptions = [
    "Incrementation d'un counter avec provider",
    "Incrementation d'un counter par une variable",
    "Gestion des tâches avec une liste de string",
    "Gestion de tâches avec options Supprimer et Modifier"
  ];

  final List<String> exerciceRouteName = [
    '/counter',
    '/gestionTacheSimples',
    '/counterParBon',

    '/gestionTachesAvancees',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.model_training, color: Colors.green),
        title: Center(child: AppText(text: "Exercices Flutter")),
      ),

      body: ListView.builder(
        itemCount: exerciceTitles.length,
        itemBuilder:(context, index){
          return ListTile(
            title: AppText(text: exerciceTitles[index]),
            subtitle: AppText(text: exerciceDescriptions[index]),
            trailing: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, exerciceRouteName[index]);
              },
              child: Container(
                height: 20,
                width: 100,
                color: Colors.green,
                child: AppText(text: "Ouvrir", color: Colors.white,),
              ),
            ),
          );
        },
      ),
    );
  }
}
