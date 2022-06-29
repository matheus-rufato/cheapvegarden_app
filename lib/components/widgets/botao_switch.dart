import 'package:flutter/material.dart';

class BotaoSwitch extends StatefulWidget {
  final Function? onClick;
  final bool valorBotao;
  final String texto;
  const BotaoSwitch({
    Key? key,
    required this.valorBotao,
    required this.texto,
    @required this.onClick,
  }) : super(key: key);

  @override
  State<BotaoSwitch> createState() => _BotaoSwitchState();
}

class _BotaoSwitchState extends State<BotaoSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.texto,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Switch(
          activeColor: Colors.green,
          value: widget.valorBotao,
          onChanged: (value) => widget.onClick!(value),
        ),
      ],
    );
  }
}
