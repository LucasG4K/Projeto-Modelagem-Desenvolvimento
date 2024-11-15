import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snacks/DAO/produto_dao.dart';

class PedidosDAO {
  num?   id;
  Timestamp? dataHora;
  int?      status;
  num?   totalPedido;
  num? avaliacaoPedido;
  int? tipoPagamento;
  String?   comentarios;
  Map<String,ProdutoDAO> produtos = {};

  PedidosDAO({this.id});

  PedidosDAO.fromDocument(Map data) {  
    if (data['id'              ] != null) id              = data['id']                 as num;
    if (data['tipo_pagamento']   != null) tipoPagamento   = data['tipo_pagamento']     as int;   
    if (data['avaliacao_pedido'] != null) avaliacaoPedido = data['avaliacao_pedido']   as num;   
    if (data['data_hora'       ] != null) dataHora        = data['data_hora']          as Timestamp;
    if (data['status'          ] != null) status          = data['status']             as int;
    if (data['total_pedido'    ] != null) totalPedido     = data['total_pedido']       as num;
    if (data['comentarios'     ] != null) comentarios     = data['comentarios']        as String;
    if (data['produtos'        ] != null) {
      for (var item in (data['produtos'] as List)) {
        produtos[item['id']] = ProdutoDAO(qtd: item['qtd']);
      }
    }
  }
  
  Map<String, dynamic> toMap() {
    return {
      if (id          != null)   'id'           : id,
      if (dataHora    != null)   'dataHora'     : dataHora,
      if (status      != null)   'status'       : status,
      if (totalPedido != null)   'totalPedido'  : totalPedido ,
      if (comentarios != null)   'comentarios'  : comentarios,
      if (produtos.isEmpty)      'produtos'     : produtos     
    };
  }

}