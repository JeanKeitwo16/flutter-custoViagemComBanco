import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/cardCarro.dart';
import 'package:custoviagem/model/carros.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarroTela extends StatefulWidget {
  final Function(int) onRemove;
  final Function(Carros) onInsert;

  const CarroTela({super.key, required this.onInsert, required this.onRemove});

  @override
  State<CarroTela> createState() => _CarroTelaState();
}

class _CarroTelaState extends State<CarroTela> {
  List<Carros> listaCarros = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    final db = DatabaseHelper.instance;
    final carrosCarregados = await db.selectCarro();
    setState(() {
      listaCarros = carrosCarregados;
    });
  }

  Future<void> _removeCar(int index) async {
    final db = DatabaseHelper.instance;
    await db.deleteCarro(listaCarros[index]); 
    setState(() {
      listaCarros.removeAt(index);
    });
    widget.onRemove(index); 
  }

  Future<void> _insertCar(Carros carro) async {
    final db = DatabaseHelper.instance;
    final id = await db.insertCarro(carro);
    setState(() {
      listaCarros.add(Carros(id: id, nomeCarro: carro.nomeCarro, autonomia: carro.autonomia));
    });
    widget.onInsert(carro);
  }

  final TextEditingController nomeCarroController = TextEditingController();
  final TextEditingController autonomiaController = TextEditingController();

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
                  controller: nomeCarroController,
                  decoration: InputDecoration(labelText: "Nome do Carro"),
                ),
                TextField(
                  controller: autonomiaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: "Autonomia (km/l)",
                  ),
                ),
                SizedBox(height: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                  ),
                  onPressed: () {
                    if (nomeCarroController.text.isNotEmpty && autonomiaController.text.isNotEmpty) {
                      double autonomiaValue = double.parse(autonomiaController.text);
                      Carros novoCarro = Carros(nomeCarro: nomeCarroController.text, autonomia: autonomiaValue);
                      _insertCar(novoCarro);
                      Navigator.pop(context);
                      nomeCarroController.clear();
                      autonomiaController.clear();
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
        itemCount: listaCarros.length,
        itemBuilder: (context, index) {
          return CardCarro(
            nomeCarro: listaCarros[index].nomeCarro,
            autonomia: listaCarros[index].autonomia,
            onRemove: () {
              _removeCar(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openModal,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
