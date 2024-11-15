import 'package:flutter/material.dart';
import 'package:snacks/Controller/pedidos_controller.dart';
import 'package:snacks/DAO/pedidos_dao.dart';
import 'package:snacks/DAO/produto_dao.dart';

class PedidosModel extends ChangeNotifier {
  var _pedido = PedidosDAO();
  var pedidoController = PedidosController();

  transformarDeDAO(PedidosDAO pedidoDAO) {_pedido = pedidoDAO;}

  get id                              => _pedido.id;
  get dataHora                        => _pedido.dataHora;
  get status                          => _pedido.status;
  get totalPedido                     => _pedido.totalPedido;
  num? get avaliacaoPedido             => _pedido.avaliacaoPedido;
  get tipoPagamento                   => _pedido.tipoPagamento;
  String? get comentarios             => _pedido.comentarios;
  Map<String,ProdutoDAO> get produtos => _pedido.produtos;

  set avaliacaoPedido(num? rating)    => _pedido.avaliacaoPedido=rating; 
  set comentarios(String? comentario) => _pedido.comentarios=comentario;


  salvarComentario({required BuildContext context, required GlobalKey<FormState> formKey}) async {
    formKey.currentState!.save();
    try {
      await pedidoController.salvaComentario(
        pedido: _pedido
      )?.then((value) => Navigator.pop(context));
    }
    catch (e) {
      showDialog (
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
