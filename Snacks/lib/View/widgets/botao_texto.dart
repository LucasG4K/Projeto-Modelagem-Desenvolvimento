// USADO NAS TELAS DE SOBREPOSIÇÃO DE CADASTRO E LOGIN

import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {
  final void Function()? onTap;
  final String? fontFamily;
  final String texto;
  final Color corTexto;

  const BotaoTexto({super.key, this.fontFamily, required this.onTap, required this.texto, required this.corTexto});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(onTap: onTap, 
        child: Text(texto, 
          style: TextStyle(
            fontFamily: fontFamily,
            decoration: TextDecoration.underline,
            color: corTexto,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        )
      ),
    );
  }
}