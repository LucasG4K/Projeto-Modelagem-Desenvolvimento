import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BotaoQuantidade extends StatelessWidget {
  final Function() diminui;
  final Function() aumenta;
  final int qtd;
  const BotaoQuantidade({super.key,required this.qtd,required this.diminui,required this.aumenta});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        IconButton(
          onPressed: diminui, 
          icon: const Icon(Icons.remove, size: 20),
          splashRadius: 20,
        ),
        Text(qtd.toString()),
        IconButton(
          onPressed: aumenta, 
          icon: const Icon(Icons.add, size: 20),
          splashRadius: 20,
        ),
      ]),
    );
  }
}