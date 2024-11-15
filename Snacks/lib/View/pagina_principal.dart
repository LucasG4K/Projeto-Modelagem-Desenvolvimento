import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:snacks/Controller/produto_controller.dart';
import 'package:snacks/Model/cliente_model.dart';
import 'package:snacks/Model/produto_model.dart';
import 'package:snacks/View/Vendedor/Produtos/produto_vendedor.dart';
import 'Cliente/Cardapio/cardapio.dart';
import 'Cliente/Pedidos/pedidos.dart';
import 'Perfil/perfil.dart';
import 'Cliente/Procurar/procurar.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  
  int _selecteIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selecteIndex = index;
    });
  }

  final List<GButton> _botoesCliente = const [
    GButton(icon: Icons.lunch_dining, text: 'Cardápio'),
    GButton(icon: Icons.search, text: 'Procurar'),
    GButton(icon: Icons.list, text: 'Pedidos'),
    GButton(icon: Icons.account_circle, text: 'Perfil')
  ];

  final List<Widget> _pagesCliente = [
    StreamProvider(
      create: (context) => ProdutoController().getProdutoStream(), initialData: ProdutoModel(),
      child: const Cardapio()
    ),
    StreamProvider(
      create: (context) => ProdutoController().getProdutoStream(), initialData: ProdutoModel(),
      child: const Procurar()
    ),
    StreamProvider(
      create: (context) => ProdutoController().getProdutoStream(), initialData: ProdutoModel(),
      child: const Pedidos(),
    ),
    const Perfil()
  ];

  final List<GButton> _botoesVendedor = const [
    GButton(icon: Icons.lunch_dining, text: 'Produtos'),
    GButton(icon: Icons.list, text: 'Pedidos'),
    GButton(icon: Icons.trending_up, text: 'Analytics'),
    GButton(icon: Icons.account_circle, text: 'Perfil')
  ];

  final List<Widget> _pagesVendedor = [
    StreamProvider(
      create: (context) => ProdutoController().getProdutoStream(), initialData: ProdutoModel(),
      child: const ProdutosVendedor()
    ),
    const Scaffold(body: Center(child: Text('Pedidos'))),
    const Scaffold(body: Center(child: Text('Analytics'))),
    const Perfil()
  ];

  @override
  Widget build(BuildContext context) {
    var cliente = context.watch<ClienteModel>();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'), title: const Text("Snacks", style: TextStyle(fontFamily: 'Amatic',fontSize: 32, color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: GNav(
        backgroundColor: const Color(0xFFAFFF9B),
        color: Colors.black,
        activeColor: Colors.black,
        selectedIndex: _selecteIndex,
        onTabChange: (index) => _navigateBottomBar(index),
        tabs: cliente.admin?_botoesVendedor:_botoesCliente),
        body: cliente.admin?_pagesVendedor[_selecteIndex]:_pagesCliente[_selecteIndex]
    );
  }
}
