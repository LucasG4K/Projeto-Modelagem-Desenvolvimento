import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snacks/DAO/pedidos_dao.dart';
import 'package:snacks/Model/pedidos_model.dart';
import 'package:snacks/View/widgets/botao_redondo_texto.dart';
import 'package:snacks/View/widgets/star_rating.dart';

List<String> tiposPagamentos = ["Pix","Débito","Crédito","Dinheiro"];

class PaginaPedido extends StatefulWidget {
  final PedidosDAO pedidoDao;
  const PaginaPedido({super.key, required this.pedidoDao });

  @override
  State<PaginaPedido> createState() => _PaginaPedidoState();
}

class _PaginaPedidoState extends State<PaginaPedido> {
  PedidosModel pedido = PedidosModel();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    pedido.transformarDeDAO(widget.pedidoDao);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Formatando data
    final data = pedido.dataHora != null ? DateFormat("dd/MM/yyyy à's' hh:mm").format(pedido.dataHora!.toDate()) : "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            leading: const CircleAvatar(radius: 30, backgroundColor: Color(0xFFAFFF9B)),
            title: const Text("Lanchonete", style: TextStyle(fontSize: 25)),
            subtitle: Text(data)),
        // Status do pedido
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromARGB(255, 217, 217, 217)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pedido.status == 0 || pedido.status == 1)
                      const Icon(Icons.schedule,
                          size: 19,
                          grade: 20,
                          color: Color.fromARGB(255, 224, 202, 8))
                    else if (pedido.status == 2)
                      const Icon(
                        Icons.timer,
                        size: 19,
                        grade: 20,
                        color: Colors.red,
                      )
                    else if (pedido.status == 3 || pedido.status == 4)
                      const Icon(
                        Icons.check_circle,
                        size: 19,
                        grade: 20,
                        color: Colors.lightGreen,
                      ),
                    const SizedBox(width: 8),
                    if (pedido.status == 0 || pedido.status == 1)
                      const Text(style: TextStyle(fontSize: 20), "Em andamento")
                    else if (pedido.status == 2)
                      const Text(
                          style: TextStyle(fontSize: 20), "Esperando retirada")
                    else if (pedido.status == 3 || pedido.status == 4)
                      const Text(style: TextStyle(fontSize: 20), "Concluído"),
                  ],
                ),
              )),
        ),
        const SizedBox(height: 20),
        // Produtos
        for (var i in pedido.produtos.keys)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Stack(
              children: [
                Row(
                  children: [
                    // Imagem
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 0.5),borderRadius: BorderRadius.circular(5)),
                        height: 55,
                        width: 85,
                        child: Image.network(pedido.produtos[i]!.linkImagem!,fit: BoxFit.contain)
                      ),
                    ),
                    // Quantidade e Nome
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text.rich(TextSpan(children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 9,
                                backgroundColor:
                                    const Color.fromARGB(255, 200, 200, 200),
                                child: Text(
                                  pedido.produtos[i]?.qtd.toString() ?? "",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 36, 36, 36)),
                                ),
                              ),
                            )),
                        TextSpan(text: pedido.produtos[i]?.nome)
                      ])),
                    ),
                  ],
                ),
                // Valor
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("R\$ ${pedido.produtos[i]?.precoVenda?.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w600),),
                  ),
                )
              ],
            ),
          ),
        const Divider(height: 35,thickness: 0.4, color: Colors.black,),
        // Total Pedido
        Padding(
          padding: const EdgeInsets.only(right: 10,left: 30),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Total", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text("R\$ ${pedido.totalPedido?.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 25)),
              )
            ],
          ),
        ),
        const Divider(height: 35,thickness: 0.4, color: Colors.black,),
        // Tipo de pagamento
        if(pedido.tipoPagamento!=1 && (pedido.status==0||pedido.status==1||pedido.status==2))
          Center(
            child: Text("Pagar na entrega - ${tiposPagamentos[pedido.tipoPagamento!]}", style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
          )
        else if(pedido.tipoPagamento==1 || pedido.status==3|| pedido.status == 4)
          Center(
            child: Text("Pago por ${tiposPagamentos[pedido.tipoPagamento!]}", style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
          ),
        // Avaliação
        if(pedido.status==4||pedido.status==3)
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Estrelas
                    Stack(
                      children: [
                        const Text( "Comentários", style: TextStyle(fontSize: 18)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              pedido.avaliacaoPedido!=null?
                                StarRating(
                                  onRatingChanged: (rating) => setState(() => pedido.status==3?pedido.avaliacaoPedido=rating:null),
                                  rating: pedido.avaliacaoPedido!.toDouble()):
                                const StarRating()
                            ],
                          ),
                        )
                      ],
                    ),
                    // Comentários
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(color: const Color.fromARGB(255, 217, 217, 217),borderRadius: BorderRadius.circular(3)),
                        child: LimitedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: pedido.status==4?Text(pedido.comentarios??"",maxLines: 20,overflow: TextOverflow.ellipsis):
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onSaved: (value) => pedido.comentarios=value,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, 
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                              ),
                          ),
                        ),
                      ),
                    ),
                    // Botão de salvar
                    pedido.status==3?Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      BotaoRedondoTexto(
                        borda: 5,
                        padding: 8,
                        margin: 0,
                        fontSize: 17,
                        onTap: () => pedido.salvarComentario(context: context, formKey: _formKey), 
                        texto: "Salvar", 
                        corFundo: const Color.fromARGB(255, 217, 217, 217), 
                        corTexto: Colors.black)
                    ]):Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
