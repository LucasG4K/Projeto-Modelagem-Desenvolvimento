import 'package:flutter/material.dart';

class UpScroll extends StatelessWidget {
  final String rotulo;
  final Widget? child;
  final Widget? floatButton;
  final double tamanhoInicial;
  final EdgeInsets? paddingInsets;
  const UpScroll({super.key, this.rotulo = "",this.floatButton,this.child,this.tamanhoInicial=0.88,this.paddingInsets});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.96,
      initialChildSize: tamanhoInicial,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding: paddingInsets??const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: paddingInsets!=null?const EdgeInsets.only(left: 24.0, top: 16.0):const EdgeInsets.all(0),
                      child: Text(rotulo,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24)),
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close))
                  ],
                ),
                Expanded(
                  child: Scaffold(
                    body: SingleChildScrollView(
                      controller: scrollController,
                      child: child??Column(
                        children: const [
                          SizedBox(height: 200),
                          Text(
                            'IMPLEMENTAÇÃO FUTURA...',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    floatingActionButton: floatButton??Container(),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
