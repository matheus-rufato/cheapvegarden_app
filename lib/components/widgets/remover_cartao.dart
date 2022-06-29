import 'package:flutter/material.dart';

class RemoverCartao extends StatelessWidget {
  final Widget cartao;
  final Function onDismissible;
  final dynamic object;
  final List<dynamic> objects;
  final int index;

  const RemoverCartao({
    Key? key,
    required this.cartao,
    required this.onDismissible,
    required this.object,
    required this.objects,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          border: Border.all(
            color: const Color.fromRGBO(50, 151, 399, 50),
            width: 1.0,
          ),
        ),
        child: const Center(
          child: Text(
            'Remover',
            style: TextStyle(
              color: Colors.white30,
              fontFamily: 'OpenSans',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      key: ValueKey<dynamic>(objects[index]),
      onDismissed: (DismissDirection direction) => onDismissible(direction),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cartao,
      ),
    );
  }
}
