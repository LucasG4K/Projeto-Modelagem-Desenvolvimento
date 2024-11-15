import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snacks/DAO/pedidos_dao.dart';

class ClienteDAO {
  String? id; // email
  String? email;
  String? nome;
  bool admin =false;
  String? tipo;
  String? cpf;
  String? sexo;
  Timestamp? nascimento;
  int avaliacao = 0;
  List<PedidosDAO> pedidos = [];

  ClienteDAO({this.id, this.nome, this.tipo, this.cpf, this.sexo, this.nascimento});

  ClienteDAO.fromDocument(Map data, String? uid) {
    if (uid != null)                id         = uid;
    if (data['admin']      != null) admin      = data['admin']      as bool;
    if (data['email']      != null) email      = data['email']      as String;
    if (data['nome']       != null) nome       = data['nome']       as String;
    if (data['tipo']       != null) tipo       = data['tipo']       as String;
    if (data['cpf']        != null) cpf        = data['cpf']        as String;
    if (data['sexo']       != null) sexo       = data['sexo']       as String;
    if (data['nascimento'] != null) nascimento = data['nascimento'] as Timestamp;
    if (data['avaliacao']  != null) avaliacao  = data['avaliacao']  as int;
    if (data['pedidos']    != null) {
      for (var item in (data['pedidos'] as List)) {
        var pedido = PedidosDAO.fromDocument(item);
        pedidos.add(pedido);
      }
    } else {
      pedidos = [];
    }
  }
  
  Map<String, dynamic> toMap() {
    return {
      if (email      != null)  'email'      : email,
      if (nome       != null)  'nome'       : nome,
      if (tipo       != null)  'tipo'       : tipo,
      if (cpf        != null)  'cpf'        : cpf,
      if (sexo       != null)  'sexo'       : sexo,
      if (nascimento != null)  'nascimento' : nascimento,
      if (pedidos.isNotEmpty)  'pedidos'    : pedidos,
                               'avaliacao'  : avaliacao,
    };
  }
}
