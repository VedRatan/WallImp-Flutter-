import 'package:flutter/material.dart';
import 'package:wallimp/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'WallImp',
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: const Home(),
    );
  }
}


