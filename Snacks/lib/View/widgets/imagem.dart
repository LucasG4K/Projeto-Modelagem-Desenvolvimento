import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snacks/Model/produto_model.dart';

class Imagem extends StatefulWidget {
  final ProdutoModel produto;
  final bool editar;
  const Imagem({super.key, required this.produto, this.editar = false});

  @override
  State<Imagem> createState() => _ImagemState();
}

class _ImagemState extends State<Imagem> {

  var _imagem;

  @override
  Widget build(BuildContext context) {
    if (widget.editar) {
      return SizedBox(
        height: 150,
        width: 150,
        child: widget.produto.linkImagem != null ?
        Image.network(widget.produto.linkImagem, fit: BoxFit.cover) :
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300]
          ),
        ),
      );
    } else {
      return Column(
        children: [
          _imagem != null ? Stack(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.file(_imagem, fit: BoxFit.cover)
              ),
              Positioned(
                top: -12,
                right: -12,
                child: IconButton(
                  tooltip: 'Remover Foto',
                  iconSize: 16,
                  color: Colors.red,
                  icon: const Icon(Icons.remove_circle_outline),
                  splashRadius: 10,
                  onPressed: () => setState(() => _imagem = null), 
                )
              )
            ]
          )
          :
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300]
            ),
            child: Center(
              child: IconButton(
                tooltip: 'Adicionar Foto',
                icon: const Icon(Icons.add_a_photo_outlined),
                highlightColor: Colors.green,
                onPressed: () => widget.produto.pegarImagem().then((value) => setState(() {value != null ?_imagem = File(value.path) : null;})),
                // splashRadius: 22,
              ),
            ),
          ),
        ],
      );
    }
  }
}