import 'package:flutter/material.dart';
import 'package:snacks/DAO/produto_dao.dart';

class ItemCarrinho {
  ItemCarrinho({required this.qtd, required this.produto});
  ProdutoDAO produto = ProdutoDAO();
  bool selecionado = false;
  int qtd = 0;
}

var produto = [
  ProdutoDAO(
      id: '0RjMmbNp5arASRU3SJP1',
      descricao: 'Suco artificial sabor uva de 200ml.',
      linkImagem:
          'https://firebasestorage.googleapis.com/v0/b/snacks-c6973.appspot.com/o/kapo_uva.png?alt=media&token=ceb742b6-432c-4d1b-a131-0eb5a79efb26',
      nome: 'Kapo Uva',
      precoVenda: 2,
      qrCodeLink: '',
      tempoPreparo: 0,
      tipo: "bebida"),
  ProdutoDAO(
      id: '0WmMHeS46H5Q2VWtinY7',
      descricao: 'Cigarrete de tamanho médio.',
      linkImagem:
          'https://firebasestorage.googleapis.com/v0/b/snacks-c6973.appspot.com/o/cigarrete.png?alt=media&token=de76c520-11cc-47dd-ac13-e4769d815b61',
      nome: 'Cigarrete',
      precoVenda: 3.5,
      qrCodeLink: '',
      tempoPreparo: 0,
      tipo: "comida"),
  ProdutoDAO(
      id: '0WmMHeS46H5Q2VWtinY7',
      descricao: 'Cigarrete de tamanho médio.',
      linkImagem:
          'https://firebasestorage.googleapis.com/v0/b/snacks-c6973.appspot.com/o/cigarrete.png?alt=media&token=de76c520-11cc-47dd-ac13-e4769d815b61',
      nome: 'Cigarrete',
      precoVenda: 3.5,
      qrCodeLink: '',
      tempoPreparo: 0,
      tipo: "comida"),
];

class CarrinhoModel extends ChangeNotifier {
  final Map<String, ItemCarrinho> _produtos = {};
  num total = 0;
  String observacoes = "";

  CarrinhoModel() {
    for (var element in produto) {
      addProdutoCarrinho(produto: element);
    }
  }

  Map<String, ItemCarrinho> get produtos => _produtos;

  modificaQtd(String? id,bool aumenta) {
    if (id != null && _produtos[id] != null) {
      aumenta?_produtos[id]!.qtd++:_produtos[id]!.qtd--;
    }
  }

  trocaSelect(String? id){
    print(_produtos[id]!.selecionado);
    if(id!=null) _produtos[id]!.selecionado=true;
    print(_produtos[id]!.selecionado);
    notifyListeners();
  }

  addProdutoCarrinho({String observacao = '', required ProdutoDAO produto}) {
    if (produto.id != null) {
      if (_produtos[produto.id] != null) {
        _produtos[produto.id]!.qtd = _produtos[produto.id]!.qtd + 1;
      } else {
        _produtos[produto.id!] = ItemCarrinho(qtd: 1, produto: produto);
      }
    }
  }
}
