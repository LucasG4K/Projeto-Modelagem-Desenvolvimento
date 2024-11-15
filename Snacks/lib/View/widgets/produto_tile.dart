
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:snacks/DAO/produto_dao.dart';

class ProdutoTile extends StatelessWidget {
  final ProdutoDAO produto;
  final void Function(BuildContext)? onPressed1;
  final void Function()? onPressed2;
  const ProdutoTile({super.key, required this.produto, this.onPressed1, this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 14),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed1,
              backgroundColor: Colors.green,
              icon: Icons.edit, 
            ),
            SlidableAction(
              onPressed: (context) => onPressed2,
              backgroundColor: Colors.red,
              icon: Icons.delete, 
            )
          ]
        ),
        child: Container(
          
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white,
            boxShadow: [BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 4),
          )],
          ),
          child: ListTile(
            leading: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.15,
              height: double.infinity,
              child: produto.linkImagem!.isNotEmpty ? Image.network(produto.linkImagem!) : const Center(child: Text('Sem foto')),
            ),
            title: Text(produto.nome.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
            subtitle: Text(produto.descricao.toString(), overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
      ),
    );
  }
}