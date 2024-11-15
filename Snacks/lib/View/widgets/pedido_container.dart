import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snacks/DAO/pedidos_dao.dart';
import 'package:snacks/Model/cliente_model.dart';
import 'package:snacks/View/Cliente/Pedidos/pagina_pedido.dart';
import 'package:snacks/View/Vendedor/Pedidos/pagina_pedido_vendedor.dart';
import 'package:snacks/View/widgets/star_rating.dart';
import 'package:snacks/View/widgets/upscroll.dart';


class PedidoContainer extends StatelessWidget {
  final PedidosDAO pedido;
  const PedidoContainer({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    var cliente = Provider.of<ClienteModel>(context);
    final data = pedido.dataHora!=null?DateFormat.yMMMEd('pt_BR').format(pedido.dataHora!.toDate()):"";
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isDismissible: true,
          isScrollControlled: true,
          context: context,
          builder: (context) => UpScroll(
            tamanhoInicial: 0.95, 
            paddingInsets: const EdgeInsets.only(top:16),
            child: cliente.admin?
              PaginaPedidoVendedor():
              PaginaPedido(pedidoDao:pedido)
            )
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
          boxShadow: [BoxShadow(
            color: Color.fromARGB(28, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4),
          )],
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data pedido
              Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios, size: 20, weight: 1,),
                    ),
                    pedido.dataHora!=null?Text(
                      data[0].toUpperCase()+data.substring(1),
                      style: const TextStyle(fontSize: 18),
                    ):Container(),
                  ],
                ),
              ),
              const Divider(height: 3, thickness: 0.4, color: Colors.black,),
              // Status
              if(pedido.status==0||pedido.status==1)
                Padding(
                  padding: const EdgeInsets.only(top:8,left: 8,right: 8),
                  child: Row(
                    children: const [
                      Icon(Icons.schedule, size: 15, weight: 1,color: Color.fromARGB(255, 224, 202, 8),),
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Text("Em andamento"),
                      )
                    ],
                  ),
                )
              else if(pedido.status==2)
                Padding(
                  padding: const EdgeInsets.only(top:8,left: 8,right: 8),
                  child: Row(
                    children: const [
                      Icon(Icons.timer, size: 15, weight: 1,color: Colors.red,),
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Text("Aguardando retirada"),
                      )
                    ],
                  ),
                )
              else if(pedido.status==3||pedido.status==4)
                Padding(
                  padding: const EdgeInsets.only(top:8,left: 8,right: 8),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, size: 15, weight: 1,color: Colors.lightGreen,),
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Text("Concluído"),
                      )
                    ],
                  ),
                ),
              // Quantidades
              Wrap(
                children: [
                  for(var i in pedido.produtos.keys)...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text.rich(TextSpan(children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle, 
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(radius:9, backgroundColor: const Color.fromARGB(255, 200, 200, 200), 
                              child: Text(pedido.produtos[i]?.qtd.toString()??"",style:const TextStyle(color: Color.fromARGB(255, 36, 36, 36)),),
                            ),
                          )
                        ),
                        TextSpan(text: pedido.produtos[i]?.nome)
                        ])
                      )
                    )
                  ]
                ],
              ),
              // Avaliação
              if(pedido.status==4 && pedido.avaliacaoPedido!=null)
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child:  Divider(height: 3, thickness: 0.4, color: Colors.black,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                      child: Stack(
                        children: [
                          const Text(
                            "Avaliação",
                            style: TextStyle(fontSize: 18),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                pedido.avaliacaoPedido!=null?StarRating(rating: pedido.avaliacaoPedido!.toDouble()):const StarRating()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              else if(pedido.status==3)
                Column(
                  children: const[
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child:  Divider(height: 3, thickness: 0.4, color: Colors.black,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 3),
                      child: Text(
                        "Avaliação pendente",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}