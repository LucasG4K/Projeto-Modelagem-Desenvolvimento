import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTexto extends StatelessWidget {
  final String? Function(String?)? validacao;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChange;
  final bool obscuro;
  final String? rotulo;
  final String? label;
  final String? valorInicial;
  final void Function()? onPressed;
  final List<TextInputFormatter>? mascaras;
  final bool senha;
  final IconData? iconePrefixo;
  final TextInputType? tipoTeclado;
  const CampoTexto({super.key, this.validacao,this.label, this.mascaras, this.tipoTeclado, this.onSaved, this.valorInicial, this.onChange, this.obscuro = false, this.senha = false, this.rotulo, this.onPressed, this.iconePrefixo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: valorInicial,
        keyboardType: tipoTeclado,
        validator: validacao,
        onSaved: onSaved,
        onChanged: onChange,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Arial'),
        obscureText: senha ? obscuro : false,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0.8),
          suffixIcon: senha ? IconButton(icon: Icon( obscuro ? Icons.visibility_off : Icons.visibility), onPressed: onPressed) : null,
          prefixIcon: iconePrefixo != null ? Icon(iconePrefixo):null,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
          hintText: rotulo,
          label: label!=null?Text(label!):null
        ),
        inputFormatters: mascaras,
      ),
    );
  }
}