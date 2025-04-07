import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class TestVariableGlob extends StatelessWidget {
  const TestVariableGlob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
          Consumer<CounterProvider>(builder: (context, counterProvider, child){return Text('${counterProvider.counter}');},)
        ],
      ),
    );
  }
}
