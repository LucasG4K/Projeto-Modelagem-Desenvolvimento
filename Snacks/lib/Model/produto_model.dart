import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snacks/Controller/produto_controller.dart';
import 'package:snacks/DAO/produto_dao.dart';

class ProdutoModel extends ChangeNotifier {

  ProdutoDAO _produto = ProdutoDAO();
  final produtoController = ProdutoController();
  final List<ProdutoDAO> _produtosLista = [];
  XFile? _imagem;
  ProdutoDAO? produto;

  // salvarDataCompra(value)      =>  _produto.dataCompra   = value;
  salvarDescricao(value)       =>  _produto.descricao    = value.trim();
  salvarLinkImagem(value)      =>  _produto.linkImagem   = value.trim();
  salvarNome(value)            =>  _produto.nome         = value.trim();
  salvarQtd(value)             =>  _produto.qtd          = int.parse(value);
  salvarPrecoVenda(value)      =>  _produto.precoVenda   = num.parse(value);
  salvarTempoPreparo(value)    =>  _produto.tempoPreparo = int.parse(value);
  salvarNaListaProdutos(value) =>  _produtosLista.add(     value);
  salvarTipo(value)            =>  _produto.tipo         = value.toLowerCase();
  incrementarQtd() => _produto.qtd++;
  decrementarQtd() => _produto.qtd--;
  novoProduto(ProdutoDAO produtoDAO) => _produto = produtoDAO;

  // get dataCompra    => _produto.dataCompra;
  get descricao     => _produto.descricao;
  get linkImagem    => _produto.linkImagem;
  get nome          => _produto.nome;
  get qtd           => _produto.qtd;
  get precoVenda    => _produto.precoVenda;
  get tempoPreparo  => _produto.tempoPreparo;
  get tipo          => _produto.tipo;
  get imagem        => _imagem;
  List<ProdutoDAO> get produtosLista => _produtosLista;

  Future<XFile?> pegarImagem() async {
    _imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
    return _imagem;
  }

  registrarProdutoAcionado({required BuildContext context, required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        if (_imagem != null) {
          await produtoController.enviarFoto(caminho:_imagem!.path, produtoDAO: _produto);
        }
        await produtoController.addProduto(
          produtoDAO: _produto,
        )!
        .then((value) => Navigator.pop(context));
      } catch (e) {
        showDialog (
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Erro ao cadastrar produto.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  editarProdutoAcionado({required BuildContext context, required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        // if (_imagem != null) {
        //   await produtoController.enviarFoto(caminho:_imagem!.path, produtoDAO: _produto);
        // }
        await produtoController.editProduto(
          produtoDAO: _produto,
        )!
        .then((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produto atualizado!')));
        });
      } catch (e) {
        showDialog (
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Erro ao cadastrar produto.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

}