import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Model/produto_model.dart';
import 'package:snacks/View/widgets/produto_container.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Consumer<ProdutoModel>(
      builder: (context, value, child) => 
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("Bebidas", textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.produtosLista.where((e) => e.tipo == 'bebida' && e.ativo).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var bebidas = value.produtosLista.where((e) => e.tipo == 'bebida' && e.ativo).toList()[index];
                  return ProdutoContainer(produto: bebidas);
                }
              )
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("Comidas", textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.produtosLista.where((e) => e.tipo == 'comida' && e.ativo).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var comidas = value.produtosLista.where((e) => e.tipo == 'comida' && e.ativo).toList()[index];
                  return ProdutoContainer(produto: comidas);
                }
              )
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("Doces", textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.produtosLista.where((e) => e.tipo == 'doce' && e.ativo).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var doces = value.produtosLista.where((e) => e.tipo == 'doce' && e.ativo).toList()[index];
                  return ProdutoContainer(produto: doces);
                }
              )
            ),
          ]
        )
      )
    );
  }
}
