import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:snacks/Model/cliente_model.dart';
import 'package:snacks/View/widgets/campo_data.dart';
import 'package:snacks/View/widgets/campo_select.dart';
import 'package:snacks/View/widgets/campo_texto.dart';
import 'package:snacks/shared/validacoes.dart';
import '../widgets/botao_redondo_texto.dart';


class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key, required});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var clienteModel = ClienteModel();
  List<bool> senha = [true, true];
  void exibirSenha() => setState(() => senha[0] = !senha[0]);
  void exibirConfirmaSenha() => setState(() => senha[1] = !senha[1]);
  
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cadastrar', style: TextStyle(fontWeight: FontWeight.w600, fontSize:30 )),
                        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    CampoTexto(
                      label: 'Nome',
                      onSaved: clienteModel.salvarNome,
                      valorInicial: clienteModel.nome,
                      validacao: Validacoes().nome,
                    ),
                    const SizedBox(height: 4),
            
                    // FORMULÁRIO EMAIL
                    CampoTexto(
                      label: 'Email',
                      onSaved: clienteModel.salvarEmail,
                      validacao: Validacoes().email,
                      tipoTeclado: TextInputType.emailAddress,
                    ),
              
                    const SizedBox(height: 4),
                    CampoSelect(
                      rotulo: 'Selecione sua ocupação*',
                      selectLista: const ['Funcionário','Técnico','Graduação','Professor'],
                      onSaved: clienteModel.salvarTipo,
                    ),
              
                    const SizedBox(height: 4),
                    CampoTexto(
                      rotulo: 'CPF*',
                      tipoTeclado: TextInputType.number,
                      validacao: Validacoes().cpf,
                      onSaved: clienteModel.salvarCpf,
                      mascaras: [MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')})],
                    ),

                    CampoTexto(
                      rotulo: 'Sexo',
                      onSaved: clienteModel.salvarSexo,
                    ),
                    const SizedBox(height: 4),
                    CampoData(
                      rotulo: "Data de nascimento",
                      onSaved: clienteModel.salvarNascimento,
                    ),
                
                    const SizedBox(height: 4),
                    CampoTexto(
                      rotulo: 'Senha*',
                      senha: true,
                      obscuro: senha[0],
                      tipoTeclado: TextInputType.visiblePassword,
                      validacao: Validacoes().senha,
                      onPressed: () => exibirSenha(),
                      onChange: clienteModel.salvarSenha,
                    ),
              
                    const SizedBox(height: 4),
                    CampoTexto(
                      rotulo: 'Confirmar Senha*',
                      senha: true,
                      obscuro: senha[1],
                      tipoTeclado: TextInputType.visiblePassword,
                      validacao: (value)=>Validacoes().senhaIncompativel!(clienteModel.senha,value),
                      onPressed: () => exibirConfirmaSenha(),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: 8),
                      child: BotaoRedondoTexto(
                        corFundo: const Color(0xFFAFFF9B),
                        corTexto: Colors.black,
                        fontWeight: FontWeight.w100,
                        onTap: () => clienteModel.registrarAcionado(context: context,formKey: _formKey),
                        texto: 'Cadastrar',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}