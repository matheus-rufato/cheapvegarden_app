import 'package:flutter/material.dart';

class TextoSetup extends StatelessWidget {
  final String texto;
  final Icon icone;
  const TextoSetup({Key? key, required this.texto, required this.icone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icone,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            texto,
            style: const TextStyle(
              color: Colors.black87,
              fontFamily: 'OpenSans',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
