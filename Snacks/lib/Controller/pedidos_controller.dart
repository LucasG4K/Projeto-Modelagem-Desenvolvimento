import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snacks/DAO/pedidos_dao.dart';

class PedidosController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void>? salvaComentario({required PedidosDAO pedido}) async {
    if (pedido.status == 3 && firebaseAuth.currentUser != null && pedido.id != null) {
      DocumentReference documentRef = _db.collection('Cliente').doc(firebaseAuth.currentUser!.uid);
      await documentRef.get().then((DocumentSnapshot value){
        var valor= value.data() as Map;
        valor['pedidos'][pedido.id]['comentarios'] = pedido.comentarios;
        valor['pedidos'][pedido.id]['avaliacao_pedido'] = pedido.avaliacaoPedido;
        valor['pedidos'][pedido.id]['status'] = 4;
        documentRef.update({
          'pedidos':valor['pedidos']
        });
      });
    }
  }
}
