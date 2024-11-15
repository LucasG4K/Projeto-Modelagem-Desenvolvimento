import 'package:flutter/material.dart';

class Procurar extends StatelessWidget {
  const Procurar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
              child: TextField(
                
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_outlined),
                  hintStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 16),
                  hintText: 'Pesquise por bebidas, comidas, doces...',
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9),
                  enabledBorder:
                      OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(10)),
                  focusedBorder:
                      OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(10)),
                ),
      
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Buscas Recentes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22))),
            ),
                  
          ],
        ),
    );
  }
}