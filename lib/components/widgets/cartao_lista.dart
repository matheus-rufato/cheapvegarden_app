import 'package:flutter/material.dart';

class CartaoLista extends StatelessWidget {
  final String titulo;
  final String? subtitulo;
  final Function? onClick;
  final Icon icone;

  const CartaoLista({
    Key? key,
    this.subtitulo,
    required this.titulo,
    @required this.onClick,
    required this.icone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icone,
        onTap: () => onClick != null ? onClick!() : null,
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Visibility(
          child: Text(
            '$subtitulo',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          visible: subtitulo != null,
        ),
      ),
      borderOnForeground: true,
      semanticContainer: true,
      shadowColor: Colors.green[900],
      elevation: 8.0,
    );
  }
}
