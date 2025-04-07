import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/gestionTaches.dart';
import '../providers/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Retour sur HomePage
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.red,),
        ),
        title: Center(child: Text("Counter Simple")),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/counterParBon");
            },
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Center(child: Text("Nombre de Clic")),
          Consumer<CounterProvider>(
            builder: (context, counterProvider, child){
              return Center(child: Text("${counterProvider.counter}", style: TextStyle(color: Colors.blue, fontSize: 20),));
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<CounterProvider>(
            builder: (context, counterProvider, child){
              return IconButton(
                onPressed: counterProvider.increment,
                icon: Icon(Icons.add, color: Colors.green,),
              );
            },
          ),
          Consumer<CounterProvider>(
            builder: (context, counterProvider, child){
              return IconButton(
                onPressed: counterProvider.decrement,
                icon: Icon(Icons.remove, color: Colors.red,),
              );
            },
          ),
        ],
      ),
    );
  }
}
