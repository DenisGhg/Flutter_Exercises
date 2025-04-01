import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_proj/pages/gestionTaches.dart';
import 'package:training_proj/pages/testVariableGlob.dart';

class CounterProvider with ChangeNotifier{

  int counter = 0;

  void increment(){
    counter++;
    notifyListeners();
  }

  void decrement(){
    counter > 0 ?  counter-- : counter;
    notifyListeners();
  }
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text("Counter With Provider")),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionTaches()));
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
