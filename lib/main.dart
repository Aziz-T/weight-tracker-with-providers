import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:providers/models/weight.dart';
import 'package:providers/state/weight_state.dart';
import 'package:providers/views/page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeightState()),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        home: WeightPage(),
      ),
    );
  }
}
