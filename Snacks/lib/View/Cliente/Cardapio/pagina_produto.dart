import 'package:flutter/material.dart';
import 'package:snacks/DAO/produto_dao.dart';
import 'package:snacks/View/widgets/botao_redondo_texto.dart';

class PaginaProduto extends StatefulWidget {
  final ProdutoDAO produto;
  const PaginaProduto({super.key, required this.produto});

  @override
  State<PaginaProduto> createState() => _PaginaProdutoState();
}

class _PaginaProdutoState extends State<PaginaProduto> {
  int qtdCarrinho = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.3,
              child: widget.produto.linkImagem!.isNotEmpty ? Image.network(widget.produto.linkImagem!, fit: BoxFit.contain,) : const Center(child: Text('Sem foto')),
            ),
        ),
        
        const Divider(
          thickness: 4,
          color: Colors.orange,
        ),

        Text(widget.produto.nome.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(widget.produto.descricao.toString(), style: const TextStyle(fontSize: 18)),
        
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('R\$ ${widget.produto.precoVenda!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(
                  onPressed: qtdCarrinho > 1 ? () {qtdCarrinho--; setState(() {});} : null,
                  icon: const Icon(Icons.remove, size: 20),
                  splashRadius: 20,
                ),
                Text(qtdCarrinho.toString()),
                IconButton(
                  onPressed: qtdCarrinho < widget.produto.qtd ? () {qtdCarrinho++; setState(() {});} : null,
                  icon: const Icon(Icons.add, size: 20),
                  splashRadius: 20,
                ),
              ]),
          ],
        ),
        Align(alignment: Alignment.topRight, child: Text('Disponível: ${widget.produto.qtd}')),
        
        const SizedBox(height: 20),
        
        const Text('AlgumaObservação?'),
        const SizedBox(height: 6),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            enabled: false,
            hintText: 'Implementação futura...',
            filled: true,
            disabledBorder:
              OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 20),

        BotaoRedondoTexto(onTap: () {}, texto: 'Adicionar', corFundo: const Color(0xFFFE724C), corTexto: Colors.white, fontSize: 18,)
      ],
    );
  }
}