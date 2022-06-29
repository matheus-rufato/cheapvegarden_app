import 'package:flutter/material.dart';

class CampoTextoFormulario extends StatefulWidget {
  final String label;
  final Widget? sufixo;
  final String? textoInicial;
  final Icon icone;
  final TextInputType teclado;
  final bool habilitar;

  final Function? validar;
  final Function? salvar;
  final Function? clicar;

  const CampoTextoFormulario(
      {Key? key,
      required this.label,
      this.sufixo,
      this.textoInicial,
      required this.icone,
      required this.teclado,
      required this.habilitar,
      @required this.validar,
      @required this.salvar,
      @required this.clicar})
      : super(key: key);

  @override
  State<CampoTextoFormulario> createState() => _CampoTextoFormularioState();
}

class _CampoTextoFormularioState extends State<CampoTextoFormulario> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        prefixIcon: widget.icone,
        suffix: widget.sufixo,
      ),
      autocorrect: true,
      initialValue: widget.textoInicial ?? '',
      keyboardType: widget.teclado,
      enabled: widget.habilitar,
      onSaved: (valor) => widget.salvar!(valor),
      validator: (valor) => widget.validar!(valor),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // onTap: () => widget.clicar!(),
    );
  }
}
