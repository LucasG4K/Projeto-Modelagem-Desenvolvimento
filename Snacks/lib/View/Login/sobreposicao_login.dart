import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snacks/Model/cliente_model.dart';
import 'package:snacks/View/widgets/botao_redondo_texto.dart';
import 'package:snacks/View/widgets/campo_texto.dart';
import 'package:snacks/shared/validacoes.dart';

class SobreposicaoLogin extends StatefulWidget {
  const SobreposicaoLogin({super.key});

  @override
  State<SobreposicaoLogin> createState() => _SobreposicaoLoginState();
}

class _SobreposicaoLoginState extends State<SobreposicaoLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var clienteModel = ClienteModel();
  bool senha = true;
  void exibirSenha() => setState(() => senha = !senha);
  // USADO COMO FUNDO DAS TELAS QUE FAZEM SOBREPOSIÇÃO COMO A TELA DE  CADASTRO E LOGIN
  @override
  Widget build(BuildContext context) {
    final tela = MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: tela * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFAFFF9B)
            ),
            child: SingleChildScrollView(
              child: Dialog.fullscreen(
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          splashRadius: 0.1,
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                          children: [
                            
                            // FORMULÁRIO EMAIL
                            CampoTexto(
                              rotulo: 'Email',
                              iconePrefixo: Icons.email_outlined,
                              onSaved: clienteModel.salvarEmail,
                              validacao: Validacoes().email,
                              tipoTeclado: TextInputType.emailAddress,
                            ),
                        
                            // FORMULÁRIO SENHA
                            CampoTexto(
                              rotulo: 'Senha',
                              tipoTeclado: TextInputType.visiblePassword,
                              senha: true,
                              obscuro: senha,
                              iconePrefixo: Icons.lock_outline,
                              onSaved: clienteModel.salvarSenha,
                              onPressed: ()=> exibirSenha(),
                              validacao: Validacoes().vazio,
                            ),
                      
                            const SizedBox(height: 22),
                        
                            // BOTÃO ENTRAR
                            BotaoRedondoTexto(
                              corFundo: const Color(0xFFFE724C),
                              corTexto: Colors.black,
                              fontFamily: "Amatic",
                              texto: 'Entrar',
                              onTap: () => clienteModel.loginAcionado(context: context, formKey: _formKey)
                            ),
                            
                          ]
                        ),
                    )
                  ]
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}