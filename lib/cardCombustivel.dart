import 'package:flutter/material.dart';

class CardCombustivel extends StatelessWidget {
  final double precoCombustivel;
  final String tipoCombustivel;
  final DateTime dataPreco;
  final Function() onRemove;

  const CardCombustivel({
    required this.precoCombustivel,
    required this.tipoCombustivel,
    required this.dataPreco,
    required this.onRemove
    });
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "$precoCombustivel",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("$tipoCombustivel", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text("$dataPreco", style: TextStyle(color: Colors.grey, fontSize: 14))
                ],
              ),
            ),
            Expanded(child: Container()),
            IconButton(onPressed: () {onRemove();}, icon: Icon(Icons.delete)),
          ],
        ));
  }
}