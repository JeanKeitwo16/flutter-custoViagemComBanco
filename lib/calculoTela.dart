import 'package:custoviagem/model/carros.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:custoviagem/DatabaseHelper.dart';
import 'package:flutter/material.dart';

class CalculoTela extends StatefulWidget {
  final List<Carros> carros;
  final List<Destinos> destinos;
  final List<Combustivel> combustivel;

  const CalculoTela({
    Key? key,
    required this.carros,
    required this.destinos,
    required this.combustivel,
  }) : super(key: key);

  @override
  State<CalculoTela> createState() => _CalculoTelaState();
}

class _CalculoTelaState extends State<CalculoTela> {
  String? _carroEscolhido;
  String? _destinoEscolhido;
  String? _combustivelEscolhido;
  double? _custoTotal;
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = DatabaseHelper.instance;

    // Load data from the database
    try {
      List<Carros> carros = await db.selectCarro();
      List<Combustivel> combustivel = await db.selectCombustivel();
      List<Destinos> destinos = await db.selectDestino();

      setState(() {
        widget.carros.clear();
        widget.carros.addAll(carros);
        widget.combustivel.clear();
        widget.combustivel.addAll(combustivel);
        widget.destinos.clear();
        widget.destinos.addAll(destinos);
        _isLoading = false; // Set loading to false
      });
    } catch (e) {
      // Handle errors appropriately
      setState(() {
        _isLoading = false;
      });
      // Optionally show a dialog or snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
    }
  }

  void calcular() {
    if (_carroEscolhido == null || _destinoEscolhido == null || _combustivelEscolhido == null) {
      // Show error if not all fields are selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
      return;
    }

    Carros carro = widget.carros.firstWhere((carro) => carro.nomeCarro == _carroEscolhido);
    Destinos destino = widget.destinos.firstWhere((destino) => destino.nomeDestino == _destinoEscolhido);
    Combustivel combustivel = widget.combustivel.firstWhere((combustivel) => combustivel.tipoCombustivel == _combustivelEscolhido);

    setState(() {
      _custoTotal = destino.distanciaDestino / carro.autonomia * combustivel.precoCombustivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loading indicator
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Calculadora de Custo",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
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
                  SizedBox(height: 20),
                  DropdownButton<String>(
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
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Selecione um combustível"),
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
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: calcular, child: Text('Calcular')),
                  SizedBox(height: 20),
                  if (_custoTotal != null)
                    Text('Custo Total: BRL $_custoTotal', style: TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
