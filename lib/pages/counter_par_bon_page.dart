import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterParBonPage extends StatelessWidget {
  CounterParBonPage({super.key});

  TextEditingController pasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              //Compteur affiche
              Center(child: Text("${context.watch<CounterBonProvider>().counter}")),
          
              // Field du bon
              TextField(
                controller: pasController,
                decoration: InputDecoration(
                  hintText: "Entrez le bon",
                ),
                /*onChanged: (value){
                  counterBonProvider.enterBon(int.parse(value));
                },*/
              ),
            ],
          ),
        ),
      
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(onPressed: (){context.read<CounterBonProvider>().increment(int.parse(pasController.text));}, child: Icon(Icons.add),),
            SizedBox(width: 10,),
            FloatingActionButton(onPressed: (){context.read<CounterBonProvider>().decrement(int.parse(pasController.text));}, child: Icon(Icons.remove),),
          ],
        )
      
      ),
    );
  }
}

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
