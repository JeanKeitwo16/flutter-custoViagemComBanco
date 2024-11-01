import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/cardDestino.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:flutter/material.dart';

class DestinoTela extends StatefulWidget {
  final List<Destinos> listaDestinos;
  final Function(Destinos) onInsert;
  final Function(int) onRemove;

  const DestinoTela({
    Key? key,
    required this.listaDestinos,
    required this.onInsert,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<DestinoTela> createState() => _DestinoTelaState();
}

class _DestinoTelaState extends State<DestinoTela> {
  final TextEditingController nomeDestinoController = TextEditingController();
  final TextEditingController distanciaDestinoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDestinos();
  }

  Future<void> _loadDestinos() async {
    final db = DatabaseHelper.instance;
    final destinos = await db.selectDestino();
    setState(() {
      widget.listaDestinos.clear();
      widget.listaDestinos.addAll(destinos);
    });
  }

  Future<void> _removeDestino(int index) async {
    final db = DatabaseHelper.instance;
    await db.deleteDestino(widget.listaDestinos[index]);
    setState(() {
      widget.listaDestinos.removeAt(index);
    });
    widget.onRemove(index);
  }

  Future<void> _insertDestino(Destinos destino) async {
    final db = DatabaseHelper.instance;
    final id = await db.insertDestino(destino);
    setState(() {
      widget.listaDestinos.add(Destinos(
        id: id,
        nomeDestino: destino.nomeDestino,
        distanciaDestino: destino.distanciaDestino,
      ));
    });
    widget.onInsert(destino);
  }

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
                  decoration: InputDecoration(labelText: "Nome do Destino"),
                ),
                TextField(
                  controller: distanciaDestinoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Distância do Destino"),
                ),
                SizedBox(height: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                  ),
                  onPressed: () {
                    if (nomeDestinoController.text.isNotEmpty &&
                        distanciaDestinoController.text.isNotEmpty) {
                      _insertDestino(Destinos(
                        nomeDestino: nomeDestinoController.text,
                        distanciaDestino: double.parse(distanciaDestinoController.text),
                      ));
                      Navigator.pop(context);
                      nomeDestinoController.clear();
                      distanciaDestinoController.clear();
                    }
                  },
                  child: Text("Cadastrar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.listaDestinos.length,
        itemBuilder: (context, index) {
          return CardDestino(
            nomeDestino: widget.listaDestinos[index].nomeDestino,
            distanciaDestino: widget.listaDestinos[index].distanciaDestino,
            onRemove: () {
              _removeDestino(index);
            },
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
