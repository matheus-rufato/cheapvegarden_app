import 'package:flutter/material.dart';

class TituloScreen extends StatelessWidget {
  final String texto;
  const TituloScreen({
    required this.texto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto.toUpperCase(),
      style: const TextStyle(
        fontSize: 32.0,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}
