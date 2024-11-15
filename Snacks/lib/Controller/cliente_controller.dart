import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snacks/DAO/cliente_dao.dart';
import 'package:snacks/Model/cliente_model.dart';

class ClienteController {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> getAdmin() async {
    final user = await _db.collection('Cliente').doc(firebaseAuth.currentUser!.uid).get();
    Map<String, dynamic> data = user.data() as Map<String, dynamic>;
    if (data['admin'] != null) {
      return data['isAd'];
    } else {
      return false;
    }
  }

  Stream<ClienteModel> getClienteStream() {
     return _db.collection('Cliente').doc(firebaseAuth.currentUser!.uid)
      .snapshots()
      .map(
        (value) {
          var temp = ClienteModel();
          temp.transformarDeDAO(ClienteDAO.fromDocument(value.data()!, firebaseAuth.currentUser!.uid));
          return temp;
        }
      );
  }

  Future<void>? registro({required ClienteDAO cliente, required String senha}) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: cliente.email!, password: senha)
      .then((value) => {
        _db.collection('Cliente')
        .doc(firebaseAuth.currentUser!.uid)
        .set({ ...cliente.toMap() })
    });
  }

  Future<void> login({required String email, required String senha, required BuildContext context}) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
  }

  Future<void> logoutAcionado(BuildContext context) async {
    await firebaseAuth.signOut(); 
  }

  // Future<List<Produto>> verCardapio();
  // Future<List<Cliente>> verClientes();
  // Future<List> verCarrinho();
  // Future<bool> avaliarCliente();
  // Future<bool> editPerfil();
  // Future<bool> procurar();
  // Future<Cliente> verPerfil();
}