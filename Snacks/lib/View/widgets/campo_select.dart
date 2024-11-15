import 'package:flutter/material.dart';
import 'package:snacks/shared/validacoes.dart';

class CampoSelect extends StatefulWidget {
  final List<String> selectLista;
  final void Function(String?)? onSaved;
  final String rotulo;
  const CampoSelect(
      {super.key,
      required this.selectLista,
      required this.rotulo,
      this.onSaved});

  @override
  State<CampoSelect> createState() => _CampoSelectState();
}

class _CampoSelectState extends State<CampoSelect> {

  @override
  Widget build(BuildContext context) {
  String currentSelectedValue = widget.selectLista.first;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: DropdownButtonFormField<String>(
          validator: Validacoes().vazio,
          onSaved: widget.onSaved,
          value: currentSelectedValue,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            label: Text(widget.rotulo),
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 117, 117, 117),
              fontSize: 18,
              fontFamily: 'Arial'
            ),
          ),
          style: const TextStyle(
            color: Color.fromARGB(255, 117, 117, 117),
            fontSize: 18,
            fontFamily: 'Arial'),
          onChanged: (String? value) {
            setState(() => currentSelectedValue = value ?? "");
          },
          items: widget.selectLista.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
          }
        ).toList()
      )
    );
  }
}
