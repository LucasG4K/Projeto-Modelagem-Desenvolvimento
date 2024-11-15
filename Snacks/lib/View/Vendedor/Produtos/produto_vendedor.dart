import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Model/produto_model.dart';
import 'package:snacks/View/Vendedor/Produtos/add_produto_vendedor.dart';
import 'package:snacks/View/widgets/produto_tile.dart';

class ProdutosVendedor extends StatelessWidget {
  const ProdutosVendedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProdutoModel>(
        builder: (context, value, child) => 
        Column(
          children: [
      
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Produtos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdicionarProduto())), icon: const Icon(Icons.add), splashRadius: 1,),
                ],
              ),
            ),
      
            Expanded(
              child: ListView.builder(
                itemCount: value.produtosLista.where((e) => e.ativo).length,
                itemBuilder: (context, index) {
                  var produto = value.produtosLista.where((e) => e.ativo).toList()[index];
                  return ProdutoTile(
                    produto: produto, 
                    onPressed1: (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => AdicionarProduto(add: false, produto: produto)))
                  );
                }
              )
            )
            
          ],
        ),
      ),
    );
  }
}