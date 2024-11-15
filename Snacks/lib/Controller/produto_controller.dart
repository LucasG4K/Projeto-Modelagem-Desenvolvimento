import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snacks/Model/produto_model.dart';
import '../DAO/produto_dao.dart';

class ProdutoController {

  final _db = FirebaseFirestore.instance;

  Stream<ProdutoModel> getProdutoStream(){
    return _db.collection('Produto')
        .snapshots()
        .map((value)  {
          var temp = ProdutoModel();
          for (var element in value.docs) {
            temp.salvarNaListaProdutos(ProdutoDAO.fromDocument(element.data(),element.id));
          }
          return temp;
        });
  }

  Future<void>? addProduto({required ProdutoDAO produtoDAO}) async {
    await _db.collection('Produto')
      .add(produtoDAO.toMap())
      .then((value) => print(value.id)); 
  }

  Future<void>? editProduto({required ProdutoDAO produtoDAO}) async {
    await _db.collection('Produto').doc(produtoDAO.id)
      .update(produtoDAO.toMap())
      .then((value) => print('Produto atualizado')); 
  }

  Future<void>? enviarFoto({required String caminho, required ProdutoDAO produtoDAO}) async {
    File file = File(caminho);
    try {
      final storage = FirebaseStorage.instance;
      Reference storageReference = storage.ref().child('ProdutoImgs/img-${DateTime.now().toString()}.jpg');
      final uploadImagem = storageReference.putFile(file);
      final storageSnapshot = await uploadImagem.whenComplete(() => null);
      produtoDAO.linkImagem = await storageSnapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
  }
  
  // Future<List<Produto>> verProdutos(String? limit);
  // Future<bool> editProduto();
  // Future<bool> deleteProduto();
  // void gerenciarLotes(String produtoId);
}
