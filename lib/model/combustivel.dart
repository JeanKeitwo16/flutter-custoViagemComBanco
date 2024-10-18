import 'dart:ffi';

import 'package:flutter/material.dart';

class Combustivel {
  int? id;
  double precoCombustivel=0.00;
  String tipoCombustivel="";
  DateTime dataPreco;
  Combustivel(
    {this.id,
      required this.precoCombustivel,
      required this.tipoCombustivel,
      required this.dataPreco,
    }
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'precoCombustivel': precoCombustivel,
      'tipoCombustivel': tipoCombustivel,
      'dataPreco': dataPreco
    };
  }

  factory Combustivel.fromMap(Map<String, dynamic> map) {
    return Combustivel(
      id: map['id'],
      precoCombustivel: map['precoCombustivel'],
      tipoCombustivel: map['tipoCombustivel'],
      dataPreco: map['dataPreco']
    );
  }
}