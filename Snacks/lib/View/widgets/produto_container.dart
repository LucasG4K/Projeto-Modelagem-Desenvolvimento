import 'package:flutter/material.dart';
import 'package:snacks/DAO/produto_dao.dart';
import 'package:snacks/View/widgets/upscroll.dart';
import 'package:snacks/View/Cliente/Cardapio/pagina_produto.dart';


class ProdutoContainer extends StatelessWidget {
  final ProdutoDAO produto;
  const ProdutoContainer({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isDismissible: true,
          isScrollControlled: true,
          context: context,
          builder: (context) => UpScroll(rotulo: "Página do Produto", child: PaginaProduto(produto: produto)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.only(top: 2.0),
          width: tamanho.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: produto.linkImagem!.isNotEmpty ? Image.network(produto.linkImagem!) : const Center(child: Text('Sem foto')),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, -1),
                  )],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                  color: Colors.white
                ),
                child: Text(produto.nome!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 1)
              ),
            ],
          ),
        ),
      ),
    );
  }
}