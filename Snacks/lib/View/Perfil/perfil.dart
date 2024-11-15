import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Model/cliente_model.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    var cliente = context.watch<ClienteModel>();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Row(
                  children: [
                    Text(cliente.nome.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit), splashRadius: 1,)
                  ],
                ),
                subtitle: Text('${cliente.tipo} - ${cliente.sexo}'),
                trailing: Icon(Icons.account_circle_outlined, size: MediaQuery.of(context).size.width * 0.15,),
              ),
              TextButton(onPressed: () => cliente.clienteController.logoutAcionado(context), child: const Text('Logout', style: TextStyle(color: Colors.red),)),
              const Divider(thickness: 2, color: Colors.black,)
            ],
          ),
        ),
      ),
    );
  }
}