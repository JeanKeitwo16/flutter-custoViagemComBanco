import 'package:custoviagem/cardDestino.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DestinoTela extends StatefulWidget {
  final List<Destinos> listaDestinos;
  final Function(int) onRemove;
  final Function(Destinos) onInsert;
  const DestinoTela({super.key, required this.onInsert, required this.onRemove, required this.listaDestinos});

  @override
  State<DestinoTela> createState() => _DestinoTelaState();
}

class _DestinoTelaState extends State<DestinoTela> {
  final TextEditingController nomeDestinoController = TextEditingController();
  final TextEditingController distanciaDestinoController = TextEditingController();
  void openModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: [
                  Text(
                    "Digite as informações necessárias",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: nomeDestinoController,
                    decoration: InputDecoration(label: Text("Nome do Destino")),
                  ),
                  TextField(
                    controller: distanciaDestinoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Distância do Destino"),
                    ),
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                      onPressed: () {
                        widget.onInsert(Destinos(nomeDestino: nomeDestinoController.text, distanciaDestino: double.parse(distanciaDestinoController.text)));
                        Navigator.pop(context);
                        nomeDestinoController.clear();
                        distanciaDestinoController.clear();
                      },
                      child: Text("Cadastrar")),
                ],
              ),
            ),
          );
        });
        
  }
 Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.listaDestinos.length,
        itemBuilder: (context, index) {
          return CardDestino(
            nomeDestino: widget.listaDestinos[index].nomeDestino,
            distanciaDestino: widget.listaDestinos[index].distanciaDestino,
            onRemove: () => widget.onRemove(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

