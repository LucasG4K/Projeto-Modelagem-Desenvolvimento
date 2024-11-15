import 'package:flutter/material.dart';
import 'package:snacks/DAO/produto_dao.dart';
import 'package:snacks/Model/produto_model.dart';
import 'package:snacks/View/widgets/botao_redondo_texto.dart';
import 'package:snacks/View/widgets/campo_select.dart';
import 'package:snacks/View/widgets/campo_texto.dart';
import 'package:snacks/View/widgets/imagem.dart';
import 'package:snacks/shared/validacoes.dart';

class AdicionarProduto extends StatefulWidget {
  final bool add;
  final ProdutoDAO? produto;
  const AdicionarProduto({super.key, this.add = true, this.produto});

  @override
  State<AdicionarProduto> createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final produtoModel = ProdutoModel();
  @override
  void initState() {
    if (!widget.add) {
      print('passou aqui');
      produtoModel.novoProduto(widget.produto!);
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snacks", style: TextStyle(fontFamily: 'Amatic',fontSize: 32, color: Colors.black, fontWeight: FontWeight.w600)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  Imagem(produto: produtoModel, editar: !widget.add),
                  
                  CampoTexto(
                    label: 'Nome',
                    valorInicial: widget.add ? null : produtoModel.nome,
                    onSaved: produtoModel.salvarNome,
                    validacao: Validacoes().vazio,
                  ),
                  CampoTexto(
                    label: 'Preço de venda',
                    valorInicial: widget.add ? null : produtoModel.precoVenda.toString(),
                    onSaved: produtoModel.salvarPrecoVenda,
                    tipoTeclado: TextInputType.number,
                    validacao: Validacoes().vazio,
                  ),
                  CampoSelect(
                    rotulo: widget.add ? 'Categoria' : 'Categoria (não é possível alterar a categoria)',
                    selectLista: const ['Bebida', 'Comida', 'Doce'],
                    onSaved: produtoModel.salvarTipo
                  ),
                  CampoTexto(
                    label: 'Descrição',
                    valorInicial: widget.add ? null : produtoModel.descricao,
                    onSaved: produtoModel.salvarDescricao,
                  ),
                  CampoTexto(
                    label: 'Tempo de preparo',
                    valorInicial: widget.add ? null : produtoModel.tempoPreparo.toString(),
                    onSaved: produtoModel.salvarTempoPreparo,
                    tipoTeclado: TextInputType.number,
                  ),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            IconButton(
                              onPressed: (produtoModel.qtd < 2) ? null : () {produtoModel.decrementarQtd(); setState(() {});},
                              icon: const Icon(Icons.remove, size: 20),
                              splashRadius: 20,
                            ),
                            Text(produtoModel.qtd.toString()),
                            IconButton(
                              onPressed: () {produtoModel.incrementarQtd(); setState(() {});},
                              icon: const Icon(Icons.add, size: 20),
                              splashRadius: 20,
                            ),
                          ]),
                        ),
                        // BotaoRedondoTexto(onTap: () {_formKey.currentState!.save(); print(produtoModel.tipo);}, texto: 'Cadastrar', fontSize: 20, corFundo: Colors.black, corTexto: Colors.white),
                        BotaoRedondoTexto(onTap: widget.add ? 
                          () => produtoModel.registrarProdutoAcionado(context: context, formKey: _formKey) 
                          : 
                          () => produtoModel.editarProdutoAcionado(context: context, formKey: _formKey),
                          texto: widget.add ? 'Cadastrar' : 'Editar', fontSize: 20, corFundo: Colors.black, corTexto: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}