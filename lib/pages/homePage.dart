import 'package:flutter/material.dart';
import 'package:training_proj/widgets/app_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> exerciceTitles = [
    "Counter Simple",
    "Counter par bon",
    "Gestion des tâches simples",
    "Gestion des tâches avancées",
    "API : randomuser.me",
    "Envoie de requête",
  ];

  final List<String> exerciceDescriptions = [
    "Incrementation d'un counter avec provider",
    "Incrementation d'un counter par une variable",
    "Gestion des tâches avec une liste de string",
    "Gestion de tâches avec options Supprimer et Modifier",
    "Affichage de la liste et le profil des utilisateurs",
    "Interface web pour lancer des reqêtes API",
  ];

  final List<String> exerciceRouteName = [
    '/counter',
    '/gestionTacheSimples',
    '/counterParBon',
    '/gestionTachesAvancees',
    '/userProfilWithRandomUserAPI',
    '/queryLauncherPage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.model_training, color: Colors.green),
        title: Center(child: AppText(text: "Exercices Flutter")),
        centerTitle: true,
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
                height: 40,
                width: 100,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AppText(text: "Ouvrir", color: Colors.white, textAlign: TextAlign.center,),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HI extends StatefulWidget {
  const HI({super.key});

  @override
  State<HI> createState() => _HIState();
}

class _HIState extends State<HI> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

