// USADO NAS TELAS DE SOBREPOSIÇÃO DE CADASTRO E LOGIN
import 'package:flutter/material.dart';

class BotaoRedondoTexto extends StatelessWidget {
  final void Function()? onTap;
  final String texto;
  final String? fontFamily;
  final FontWeight fontWeight;
  final double? padding;
  final double? margin;
  final double? fontSize;
  final Icon? iconeAnterior;
  final double? borda;
  final Color corFundo;
  final Color corTexto;
  
  const BotaoRedondoTexto({super.key, this.fontSize = 32, this.margin, this.fontWeight = FontWeight.w600, this.fontFamily, this.iconeAnterior, this.padding, this.borda, required this.onTap, required this.texto, required this.corFundo, required this.corTexto});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding??14),
        margin: EdgeInsets.symmetric(horizontal: margin??25),
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(borda??56),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconeAnterior!=null?Padding(
              padding: const EdgeInsets.only(top: 1,right: 10),
              child: iconeAnterior,
            ):Container(width: 0, height: 0),
            Text(
              texto,
              style: TextStyle(
                fontFamily: fontFamily,
                color: corTexto,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            )
          ]
        ),
      ),
    );
  }
}