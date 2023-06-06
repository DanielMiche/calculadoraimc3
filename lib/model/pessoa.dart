import 'package:flutter/material.dart';

class Pessoa {
  int _id = 0;
  String _nome = "";
  double _altura;
  List<Informacao> _informacoes = [];

  Pessoa(this._id, this._nome, this._altura, this._informacoes);

  int get id => _id;
  String get nome => _nome;
  double get altura => _altura;
  List<Informacao> get informacoes => _informacoes;

  set nome(String nome) {
    _nome = nome;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set id(int id) {
    _id = id;
  }

  set informacoes(List<Informacao> informacoes) {
    _informacoes = informacoes;
  }
}

class Informacao {
  int _id = 0;
  double _peso;

  Informacao(this._id, this._peso);
  int get id => _id;
  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  set id(int id) {
    _id = id;
  }

  double calcularIMC(double altura) {
    return _peso / (altura * altura);
  }

  String resultadoIMC(double altura) {
    double valor = calcularIMC(altura);

    if (valor < 16) {
      return "Magreza Grave";
    } else if (valor >= 16 && valor < 17) {
      return "Magreza Moderada";
    } else if (valor >= 17 && valor < 18.5) {
      return "Magreza Leve";
    } else if (valor >= 18.5 && valor < 25) {
      return "Saudável";
    } else if (valor >= 25 && valor < 30) {
      return "Sobrepeso";
    } else if (valor >= 30 && valor < 35) {
      return "Obesidade Grau I";
    } else if (valor >= 35 && valor < 40) {
      return "Obesidade Grau II (Severa)";
    } else {
      return "Obesidade Grau III (Mórbida)";
    }
  }
}
