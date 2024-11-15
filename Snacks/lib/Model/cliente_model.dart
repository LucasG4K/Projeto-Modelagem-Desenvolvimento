import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snacks/DAO/cliente_dao.dart';
import 'package:snacks/DAO/pedidos_dao.dart';
import 'package:snacks/Model/carrinho_model.dart';
import '../Controller/cliente_controller.dart';

class ClienteModel {

  var _cliente = ClienteDAO();
  var carrinho = CarrinhoModel();
  final clienteController = ClienteController();

  transformarDeDAO(ClienteDAO clienteDAO) {_cliente = clienteDAO;}

  transformarEmDAO() => _cliente;

  bool ocupado = false;

  String? _senha;

  salvarId(value)              =>  _cliente.id         = value.trim();
  salvarNome(value)            =>  _cliente.nome       = value.trim();
  salvarSexo(value)            =>  _cliente.sexo       = value.trim();
  salvarCpf(value)             =>  _cliente.cpf        = value.trim();
  salvarEmail(value)           =>  _cliente.email      = value.trim();
  salvarTipo(value)            =>  _cliente.tipo       = value.trim();
  salvarSenha(value)           =>  _senha              = value.trim();
  salvarNascimento(String? value)      { 
    DateTime? data;
    if(value!=null) data = DateTime.tryParse(value.replaceAll('/', '-'));
    _cliente.nascimento = Timestamp.fromDate(data??DateTime.now());
  }

  get id                          => _cliente.id;
  bool get admin                  => _cliente.admin;
  get nome                        => _cliente.nome;
  get sexo                        => _cliente.sexo;
  get cpf                         => _cliente.cpf;
  Timestamp? get nascimento       => _cliente.nascimento;
  get email                       => _cliente.email;
  get tipo                        => _cliente.tipo;
  List<PedidosDAO> get pedidos    => _cliente.pedidos;
  get senha                       => _senha;

  loginAcionado({required BuildContext context, required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final myContext = context;
      try {
        await clienteController.login(
          email: _cliente.email!.trim(),
          senha: _senha!.trim(),
          context: context,
        ).then((value) => Navigator.pop(context));
      }
      catch (e) {
        showDialog (
          context: myContext,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Email ou senha inválidos.'),
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


  registrarAcionado({required BuildContext context, required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await clienteController.registro(
          cliente: _cliente,
          senha: _senha!
        )?.then((value) => Navigator.pop(context));
      }
      catch (e) {
        showDialog (
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('E-mail já cadastrado.'),
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
}