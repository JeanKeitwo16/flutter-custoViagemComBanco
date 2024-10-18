import 'package:custoviagem/calculoTela.dart';
import 'package:custoviagem/carroTela.dart';
import 'package:custoviagem/destinoTela.dart';
import 'package:custoviagem/gasolinaTela.dart';
import 'package:custoviagem/model/carros.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:custoviagem/model/carrosDAO.dart';
import 'package:custoviagem/model/combustivelDAO.dart';
import 'package:custoviagem/model/destinosDAO.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppCustoViagem());
}

class AppCustoViagem extends StatefulWidget {
  const AppCustoViagem({super.key});

  @override
  State<AppCustoViagem> createState() => _AppCustoViagemState();
}

class _AppCustoViagemState extends State<AppCustoViagem> {
  int telaSelecionada = 1;

  List<Carros> listaCarros = [
    Carros(nomeCarro: "Golf GT", autonomia: 21.5),
    Carros(nomeCarro: "Fiat Uno", autonomia: 15.0),
  ];

  List<Destinos> listaDestinos = [
    Destinos(nomeDestino: "Durazno", distanciaDestino: 200.0),
    Destinos(nomeDestino: "Montevideo", distanciaDestino: 350.0),
  ];

  List<Combustivel> listaCombustivel = [
    Combustivel(
        precoCombustivel: 5.45,
        tipoCombustivel: "Gasolina",
        dataPreco: DateTime.now()),
    Combustivel(
        precoCombustivel: 4.20,
        tipoCombustivel: "Álcool",
        dataPreco: DateTime.now()),
  ];

  void _removerCarro(int index) {
    setState(() {
      listaCarros.removeAt(index);
    });
  }

  void _inserirCarro(Carros novoCarro) {
    setState(() {
      listaCarros.add(novoCarro);
    });
  }

  void _inserirDestino(Destinos novoDestino) {
    setState(() {
      listaDestinos.add(novoDestino);
    });
  }

  void _removerDestino(int index) {
    setState(() {
      listaDestinos.removeAt(index);
    });
  }

  void _inserirCombustivel(Combustivel novoCombustivel) {
    setState(() {
      listaCombustivel.add(novoCombustivel);
    });
  }

  void _removerCombustivel(int index) {
    setState(() {
      listaCombustivel.removeAt(index);
    });
  }

  void opcaoSelecionada(int opcao) {
    setState(() {
      telaSelecionada = opcao;
    });
  }

  @override
  Widget build(BuildContext context) {
     final List<Widget> listaTelas = <Widget>[
    CarroTela(listaCarros: listaCarros, onInsert: _inserirCarro, onRemove: _removerCarro),
    CalculoTela(
        carros: listaCarros,
        destinos: listaDestinos,
        combustivel: listaCombustivel),
    DestinoTela(listaDestinos: listaDestinos, onInsert: _inserirDestino, onRemove: _removerDestino),
    GasolinaTela(listaCombustivel: listaCombustivel, onInsert: _inserirCombustivel, onRemove: _removerCombustivel),
  ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Custo Viagem",
      home: Scaffold(
        body: Center(child: listaTelas[telaSelecionada]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: const Color.fromARGB(255, 88, 88, 88),
          fixedColor: const Color.fromARGB(255, 255, 255, 255),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental_rounded),
            label: 'Carro',
            backgroundColor: Color.fromARGB(255, 0, 166, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Calculo',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Destinos',
            backgroundColor: Color.fromARGB(255, 255, 153, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gas_meter_rounded),
            label: 'Gasolina',
            backgroundColor: Color.fromARGB(255, 255, 17, 0),
          ),
        ],
        currentIndex: telaSelecionada,
        onTap: opcaoSelecionada,
      ),
    )
    );
  }
}
