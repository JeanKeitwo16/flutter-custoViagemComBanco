import 'package:flutter/material.dart';

class CardCarro extends StatelessWidget {
  final String nomeCarro;
  final double autonomia;
  final Function() onRemove;

  const CardCarro({
    required this.nomeCarro,
    required this.autonomia,
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
                    "$nomeCarro",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("$autonomia", style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Expanded(child: Container()),
            IconButton(onPressed: () {onRemove();}, icon: Icon(Icons.delete)),
          ],
        ));
  }
}