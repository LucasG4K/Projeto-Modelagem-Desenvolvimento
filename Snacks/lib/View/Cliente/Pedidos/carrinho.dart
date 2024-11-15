import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Model/carrinho_model.dart';
import 'package:snacks/View/widgets/botao_quantidade.dart';

class Carrinho extends StatelessWidget {
  final String? rotulo;
  final BuildContext? childContext;
  const Carrinho({super.key, this.rotulo, this.childContext});

  @override
  Widget build(BuildContext context) {
    childContext != null ? context = childContext! : null;
    var carrinho = context.watch<CarrinhoModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          for (var i in carrinho.produtos.keys)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Color.fromARGB(36, 0, 0, 0),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 5),
                  )],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  color: Colors.white
                ),
                child: ExpansionTile(
                  onExpansionChanged: (value) => carrinho.trocaSelect(i),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: SizedBox(
                    width: 80,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(carrinho.produtos[i]!.produto.linkImagem!,fit: BoxFit.cover)
                    ),
                  ),
                  title: Row(
                    children: [
                      CircleAvatar(radius: 7, backgroundColor: const Color.fromARGB(255, 200, 200, 200), 
                        child: Text(
                          carrinho.produtos[i]?.qtd.toString()??"",
                          style:const TextStyle(color: Color.fromARGB(255, 36, 36, 36),fontSize: 8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(carrinho.produtos[i]!.produto.nome??"", style: const TextStyle(fontSize: 17)),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:2),
                    child: Text(carrinho.produtos[i]!.produto.descricao??"", style: const TextStyle(fontSize: 14)),
                  ),
                  trailing: const Icon(Icons.expand_more),
                  children: [
                    if(carrinho.produtos[i]!.selecionado)
                      Text("asssda")
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
