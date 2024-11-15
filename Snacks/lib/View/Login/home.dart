import 'package:flutter/material.dart';
import 'package:snacks/View/Login/sobreposicao_login.dart';
import '../widgets/botao_texto.dart';
import '../widgets/botao_redondo_texto.dart';
import 'cadastro_cliente.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFE724C),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // IMAGEM DA LOGO
                Image.asset('assets/images/logo.png'),

                // BOTÃO ABRIR SOBREPOSIÇÃO PARA CADASTRAR
                BotaoRedondoTexto(
                  corFundo: const Color(0xFFF1D080),
                  corTexto: Colors.black,
                  fontFamily: "Amatic",
                  texto: 'Cadastrar',
                  onTap: () => showModalBottomSheet(
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    isDismissible: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const CadastroCliente()
                  ),
                ),

                BotaoTexto(
                  corTexto: Colors.white,
                  fontFamily: "Amatic",
                  texto: 'Entrar',
                  onTap: () => showDialog(context: context, builder: (BuildContext context) => const SobreposicaoLogin()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}