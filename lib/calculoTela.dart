import 'package:custoviagem/model/carros.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:flutter/material.dart';

class CalculoTela extends StatefulWidget {
  final List<Carros> carros;
  final List<Destinos> destinos;
  final List<Combustivel> combustivel;
  const CalculoTela({super.key, required this.carros, required this.destinos, required this.combustivel});

  @override
  State<CalculoTela> createState() => _CalculoTelaState();
}

class _CalculoTelaState extends State<CalculoTela> {
  String? _carroEscolhido;
  String? _destinoEscolhido;
  String? _combustivelEscolhido;
  double? _custoTotal;
  void calcular(){
    Carros carro = widget.carros.firstWhere((carro) => carro.nomeCarro == _carroEscolhido);
    Destinos destinos = widget.destinos.firstWhere((destinos) => destinos.nomeDestino == _destinoEscolhido);
    Combustivel combustivel = widget.combustivel.firstWhere((combustivel) => combustivel.tipoCombustivel == _combustivelEscolhido);
    setState(() {
      _custoTotal = destinos.distanciaDestino / carro.autonomia * combustivel.precoCombustivel;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              const Text(
                "Calculadora de Custo",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Selecione um carro"),
                  value: _carroEscolhido,
                  items: widget.carros.map((Carros carro) {
                    return DropdownMenuItem<String>(
                      value: carro.nomeCarro,
                      child: Text(carro.nomeCarro),
                    );
                  }).toList(),
                  onChanged: (String? novoCarro) {
                    setState(() {
                      _carroEscolhido = novoCarro;
                    });
                  },
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Selecione um destino"),
                  value: _destinoEscolhido,
                  items: widget.destinos.map((Destinos destino) {
                    return DropdownMenuItem<String>(
                      value: destino.nomeDestino,
                      child: Text(destino.nomeDestino),
                    );
                  }).toList(),
                  onChanged: (String? novoDestino) {
                    setState(() {
                      _destinoEscolhido = novoDestino;
                    });
                  },
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Selecione um combustivel"),
                  value: _combustivelEscolhido,
                  items: widget.combustivel.map((Combustivel combustivel) {
                    return DropdownMenuItem<String>(
                      value: combustivel.tipoCombustivel,
                      child: Text(combustivel.tipoCombustivel),
                    );
                  }).toList(),
                  onChanged: (String? novoCombustivel) {
                    setState(() {
                      _combustivelEscolhido = novoCombustivel;
                    });
                  },
                ),
              ),
              SizedBox(height: 35),
              ElevatedButton(onPressed: calcular, child: Text('Calcular')),
              SizedBox(height: 35),
              if (_custoTotal != null)
              SizedBox(child: Text('BRL$_custoTotal', style: TextStyle(fontSize: 20),),),
            ],
          ),
      ),
    );
  }
}