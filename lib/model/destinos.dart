import 'package:flutter/material.dart';

class Destinos {
  int? id;
  String nomeDestino="";
  double distanciaDestino=0;
  Destinos(
    {this.id,
      required this.nomeDestino,
      required this.distanciaDestino,
    }
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeDestino': nomeDestino,
      'distanciaDestino': distanciaDestino,
    };
  }

  factory Destinos.fromMap(Map<String, dynamic> map) {
    return Destinos(
      id: map['id'],
      nomeDestino: map['nomeDestino'],
      distanciaDestino: map['distanciaDestino'],
    );
  }
}