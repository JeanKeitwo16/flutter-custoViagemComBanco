import 'package:custoviagem/cardCombustivel.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GasolinaTela extends StatefulWidget {
  final List<Combustivel> listaCombustivel;
  final Function(int) onRemove;
  final Function(Combustivel) onInsert;
  const GasolinaTela({super.key, required this.onInsert, required this.onRemove, required this.listaCombustivel});

  @override
  State<GasolinaTela> createState() => _GasolinaTelaState();
}

class _GasolinaTelaState extends State<GasolinaTela> {
  final TextEditingController precoCombustivelController = TextEditingController();
  final TextEditingController tipoCombustivelController = TextEditingController();
   final TextEditingController dataprecoController = TextEditingController();
   DateTime? selectedDate;
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
                    controller: precoCombustivelController,
                    decoration: InputDecoration(label: Text("Preço do Destino")),
                  ),
                  TextField(
                    controller: tipoCombustivelController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Tipo do Combustivel"),
                    ),
                  ),
                  TextField(
                    controller: dataprecoController,
                    readOnly: true,
                    decoration: InputDecoration(
                      label: Text("Data do Preço"),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(3000),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          dataprecoController.text =
                              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"; // Formata a data
                        });
                      }
                    },
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
                        widget.onInsert(Combustivel(tipoCombustivel: tipoCombustivelController.text, dataPreco: selectedDate!, precoCombustivel: double.parse(precoCombustivelController.text)));
                        Navigator.pop(context);
                        tipoCombustivelController.clear();
                        dataprecoController.clear();
                        precoCombustivelController.clear();
                        selectedDate = null;
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
        itemCount: widget.listaCombustivel.length,
        itemBuilder: (context, index) {
          return CardCombustivel(
            precoCombustivel: widget.listaCombustivel[index].precoCombustivel,
            tipoCombustivel: widget.listaCombustivel[index].tipoCombustivel,
            dataPreco: widget.listaCombustivel[index].dataPreco,
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

