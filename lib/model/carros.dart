import 'package:flutter/material.dart';

class Carros {
  int? id;
  String nomeCarro="";
  double autonomia=0;
  Carros(
    {this.id,
      required this.nomeCarro,
      required this.autonomia,
    }
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCarro': nomeCarro,
      'autonomia': autonomia,
    };
  }

  factory Carros.fromMap(Map<String, dynamic> map) {
    return Carros(
      id: map['id'],
      nomeCarro: map['nomeCarro'],
      autonomia: map['autonomia'],
    );
  }
  
}