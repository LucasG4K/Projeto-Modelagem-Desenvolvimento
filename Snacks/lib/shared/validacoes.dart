import 'package:cpf_cnpj_validator/cpf_validator.dart';

class Validacoes {

  String? Function(String?)? vazio = (valor) {
    if (valor!.isEmpty) { return "*Campo Obrigatório"; }
    return null;
  };

  String? Function(String?)? nome = (valor) {
    if (valor!.isEmpty) { return "*Campo Obrigatório"; }
    else if (valor.trim().split(' ').length <= 1) { return "*Preencha seu nome completo"; }
    return null;
  };

  String? Function(String?)? email = (valor) {
    if (valor!.isEmpty) { return "*Campo Obrigatório"; }
    else if (!emailRegEx().hasMatch(valor.trim())) { return "*Email inválido"; }
    return null;

  };

  String? Function(String?)? senha = (value) {
    if (value!.isEmpty) { return "*Campo Obrigatório"; }
    else if (value.toString().length < 6) { return '*Senha muito curta'; }
    return null;
  };

  String? Function(String?, String?)? senhaIncompativel = (value1,value2) {
    if (value2!.isEmpty) { return "*Campo Obrigatório"; }
    else if (value1 != value2) { return "*Senhas Incompatíveis"; }
    return null;
  };

  String? Function(String?)? cpf = (valor) {
    if (valor!.isEmpty) { return "*Campo Obrigatório"; }
    else if (!CPFValidator.isValid(valor)) { return "*CPF inválido"; }
    return null;
  };

  String? Function(String?)? data = (valor) {
    if (valor!.isEmpty) { return null; }
    else if (DateTime.tryParse(valor.replaceAll('/', '-'))!=null) { return "*Data inválida"; }
    return null;
  };
}


RegExp emailRegEx() => RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");