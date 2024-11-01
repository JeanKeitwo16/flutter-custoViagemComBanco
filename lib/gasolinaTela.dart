import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/cardCombustivel.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:flutter/material.dart';

class GasolinaTela extends StatefulWidget {
  final List<Combustivel> listaCombustivel;
  final Function(Combustivel) onInsert;
  final Function(int) onRemove;

  const GasolinaTela({
    Key? key,
    required this.listaCombustivel,
    required this.onInsert,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<GasolinaTela> createState() => _GasolinaTelaState();
}

class _GasolinaTelaState extends State<GasolinaTela> {
  late List<Combustivel> listaCombustivel = [];
  final TextEditingController precoCombustivelController = TextEditingController();
  final TextEditingController tipoCombustivelController = TextEditingController();
  final TextEditingController dataPrecoController = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    _loadCombustiveis();
  }

  Future<void> _loadCombustiveis() async {
    final db = DatabaseHelper.instance;
    final combustiveis = await db.selectCombustivel();
    setState(() {
      listaCombustivel = combustiveis;
    });
  }

  Future<void> _removeCombustivel(int index) async {
    final db = DatabaseHelper.instance;
    await db.deleteCombustivel(listaCombustivel[index]);
    setState(() {
      listaCombustivel.removeAt(index);
    });
    widget.onRemove(index);
  }

  Future<void> _insertCombustivel(Combustivel combustivel) async {
    final db = DatabaseHelper.instance;
    final id = await db.insertCombustivel(combustivel);
    combustivel.id = id;
    setState(() {
      listaCombustivel.add(combustivel);
    });
    widget.onInsert(combustivel);
  }

  void openModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              Text(
                "Digite as informações necessárias",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              TextField(
                controller: precoCombustivelController,
                decoration: InputDecoration(labelText: "Preço do Combustível"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tipoCombustivelController,
                decoration: InputDecoration(labelText: "Tipo do Combustível"),
              ),
              GestureDetector(
                child: AbsorbPointer(
                  child: TextField(
                    controller: dataPrecoController,
                    decoration: InputDecoration(labelText: "Data do Preço"),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(3000),
                  );
                  if (pickedDate != null) {
                    dataPrecoController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
              ),
              SizedBox(height: 35),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                ),
                onPressed: () {
                  if (precoCombustivelController.text.isNotEmpty &&
                      tipoCombustivelController.text.isNotEmpty &&
                      dataPrecoController.text.isNotEmpty) {
                    final novoCombustivel = Combustivel(
                      precoCombustivel: double.parse(precoCombustivelController.text),
                      tipoCombustivel: tipoCombustivelController.text,
                      dataPreco: dataPrecoController.text,
                    );
                    _insertCombustivel(novoCombustivel);
                    Navigator.pop(context);
                    precoCombustivelController.clear();
                    tipoCombustivelController.clear();
                    dataPrecoController.clear();
                  }
                },
                child: Text("Cadastrar"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listaCombustivel.length,
        itemBuilder: (context, index) {
          return CardCombustivel(
            precoCombustivel: listaCombustivel[index].precoCombustivel,
            tipoCombustivel: listaCombustivel[index].tipoCombustivel,
            dataPreco: listaCombustivel[index].dataPreco,
            onRemove: () {
              _removeCombustivel(index);
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
