import 'package:calculadora_imc_tres/pages/pessoas_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PessoasPage(),
    );
  }
}
