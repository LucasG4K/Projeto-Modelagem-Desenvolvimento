import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snacks/shared/validacoes.dart';

class CampoData extends StatefulWidget {
  final String? rotulo;
  final String? label;
  final void Function(String?)? onSaved;
  const CampoData({super.key, this.rotulo, this.onSaved, this.label});

  @override
  State<CampoData> createState() => _CampoDataState();
}

class _CampoDataState extends State<CampoData> {
  TextEditingController dateController = TextEditingController(); 
  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: TextFormField(
          validator: Validacoes().data,
          style: const TextStyle(color: Color.fromARGB(255, 117, 117, 117), fontSize: 18, fontFamily: 'Arial'),
          controller: dateController, 
          decoration: InputDecoration( 
            label: widget.label != null? Text(widget.label!) : null,
            suffixIcon: const Icon(Icons.calendar_today),
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18, fontFamily: 'Arial'),
            hintText: widget.rotulo,
          ),
          readOnly: true, 
          onSaved: widget.onSaved,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950), 
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
              setState(() => dateController.text = formattedDate);
              //widget.onSaved!(pickedDate);
            }
          },
        )
      );
  }
}
