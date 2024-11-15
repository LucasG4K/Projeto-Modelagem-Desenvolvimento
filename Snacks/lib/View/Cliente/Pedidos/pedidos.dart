import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Model/cliente_model.dart';
import 'package:snacks/Model/produto_model.dart';
import 'package:snacks/View/Cliente/Pedidos/carrinho.dart';
import 'package:snacks/View/widgets/botao_redondo_texto.dart';
import 'package:snacks/View/widgets/pedido_container.dart';
import 'package:snacks/View/widgets/upscroll.dart';

class Pedidos extends StatelessWidget {
  const Pedidos({super.key});

  @override
  Widget build(BuildContext context) {
    var contextPedido = context;
    var cliente = context.watch<ClienteModel>();
    var produto = context.watch<ProdutoModel>();
    // Carrega os produtos nos pedidos
    for (var pedido in cliente.pedidos) {
      num soma=0;
      for (var product in pedido.produtos.keys) {
        var aux = pedido.produtos[product]?.qtd;
        if(produto.produtosLista.isNotEmpty)pedido.produtos[product]=produto.produtosLista.firstWhere((element) => element.id==product);
        if(aux!=null) {
          pedido.produtos[product]?.qtd=aux;
          soma=soma+(aux*(pedido.produtos[product]?.precoVenda??0));
        }
      }
      pedido.totalPedido=soma;
    }
    return Padding(
      padding: const EdgeInsets.only(top:8),
      child: Scaffold(
        body: Consumer<ClienteModel>(
          builder: (context,value,child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Wrap(
              runSpacing: 8,
              children: [
                const Align(alignment: Alignment.centerLeft, child: Text("Em andamento", textAlign: TextAlign.start, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))),
                for(var i in cliente.pedidos.where((e) => (e.status == 0 || e.status == 1 || e.status == 2))) 
                  PedidoContainer(pedido: i),
                const Align(alignment: Alignment.centerLeft, child: Text("Concluidos", textAlign: TextAlign.start, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))),
                for(var i in cliente.pedidos.where((e) => (e.status == 3|| e.status == 4))) 
                  PedidoContainer(pedido: i)
              ],
            ),
          )
        ),
        // Ver Carrinho
        floatingActionButton: BotaoRedondoTexto(
          iconeAnterior: const Icon(Icons.shopping_cart),
          padding: 10,
          fontSize: 26,
          corFundo: Colors.grey,
          fontWeight: FontWeight.w200,
          texto: "Carrinho",
          corTexto: Colors.black,
          onTap: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isDismissible: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => UpScroll(
              floatButton: cliente.admin?Container():
                BotaoRedondoTexto(
                  onTap: ()=>{}, 
                  texto: "Continuar", 
                  padding: 10,
                  fontSize: 26,
                  borda: 10,
                  fontWeight: FontWeight.w200,
                  corFundo: Color.fromARGB(255, 254, 115, 76), 
                  corTexto: Colors.white),
              paddingInsets: EdgeInsets.all(0),
              rotulo: "Carrinho",
              child: Carrinho(childContext: contextPedido)
            )
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
