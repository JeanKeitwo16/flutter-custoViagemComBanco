import 'package:flutter/material.dart';

class Calculo {
  int? id;
  String? carroEscolhido;
  String? destinoEscolhido;
  String? combustivelEscolhido;
  double? custoTotal;

  Calculo(
    {this.id,
      required this.carroEscolhido,
      required this.combustivelEscolhido,
      required this.destinoEscolhido,
      required this.custoTotal

    }
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carroEscolhido': carroEscolhido,
      'combustivelEscolhido': combustivelEscolhido,
      'destinoEscolhido': destinoEscolhido,
      'custoTotal': custoTotal
    };
  }

  factory Calculo.fromMap(Map<String, dynamic> map) {
    return Calculo(
      id: map['id'],
      carroEscolhido: map['carroEscolhido'],
      combustivelEscolhido: map['combustivelEscolhido'],
      destinoEscolhido: map['destinoEscolhido'],
      custoTotal: map['custoTotal']
    );
  }
  
}