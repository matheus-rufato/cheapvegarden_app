import 'package:cheapvegarden_app/models/cultura.dart';
import 'package:cheapvegarden_app/models/setup.dart';
import 'package:cheapvegarden_app/services/cultura_service.dart';
import 'package:cheapvegarden_app/validators/setup_validacao.dart';
import 'package:flutter/material.dart';

import '../components/widgets/botao_switch.dart';
import '../components/widgets/campo_texto_formulario.dart';
import '../components/widgets/titulo_screen.dart';

class CulturaFormCreateScreen extends StatefulWidget {
  const CulturaFormCreateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CulturaFormCreateScreen> createState() =>
      _CulturaFormCreateScreenState();
}

class _CulturaFormCreateScreenState extends State<CulturaFormCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CulturaService _culturaService = CulturaService();
  final SetupValidacao _setupValidacao = SetupValidacao();

  String? _nomeCultura;
  late int? _umidadeMaxima;
  late int? _umidadeMinima;
  late String? _textoVerificacaoMinimo;
  late String? _textoVerificacaoMaximo;
  bool _tipoControle = true;
  bool _status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHEAPVEGARDEN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              salvar(context);
            },
            icon: const Icon(Icons.check_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: TituloScreen(texto: 'criar cultura'),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                border: Border.all(
                  color: const Color.fromRGBO(50, 151, 399, 50),
                  width: 1.0,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CampoTextoFormulario(
                          label: 'Cultura',
                          icone: Icon(
                            Icons.label,
                            color: Colors.green.shade900,
                          ),
                          teclado: TextInputType.name,
                          habilitar: true,
                          sufixo: const Text('%'),
                          validar: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Campo obrigatório!';
                            }
                            return null;
                          },
                          salvar: (valor) {
                            _nomeCultura = valor;
                          },
                          clicar: null,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CampoTextoFormulario(
                        label: 'Umidade Mínima',
                        icone: const Icon(
                          Icons.water_drop_outlined,
                          color: Colors.lightBlue,
                        ),
                        teclado: const TextInputType.numberWithOptions(
                            decimal: false),
                        habilitar: true,
                        sufixo: const Text('%'),
                        salvar: (valor) {
                          _umidadeMinima = int.parse(valor!);
                        },
                        validar: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Campo obrigatório!';
                          } else {
                            _umidadeMinima = int.parse(valor);
                            _textoVerificacaoMinimo = _setupValidacao
                                .validarUmidadeMinima(_umidadeMinima!);
                            return _textoVerificacaoMinimo;
                          }
                        },
                        clicar: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CampoTextoFormulario(
                        label: 'Umidade Máxima',
                        icone: const Icon(
                          Icons.water_drop_sharp,
                          color: Colors.lightBlue,
                        ),
                        teclado: const TextInputType.numberWithOptions(
                            decimal: false),
                        habilitar: true,
                        sufixo: const Text('%'),
                        salvar: (valor) {
                          setState(() {
                            _umidadeMaxima = int.parse(valor!);
                          });
                        },
                        validar: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Campo obrigatório!';
                          } else {
                            _umidadeMaxima = int.tryParse(valor)!;
                            _textoVerificacaoMaximo = _setupValidacao
                                .validarUmidadeMaxima(_umidadeMaxima!);
                            if (_textoVerificacaoMaximo != null) {
                              return _textoVerificacaoMaximo;
                            } else if (_textoVerificacaoMinimo == null) {
                              return _setupValidacao.validarUmidades(
                                  _umidadeMaxima, _umidadeMinima);
                            }
                          }
                        },
                        clicar: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Container(
                        // margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          border: Border.all(
                            color: const Color.fromRGBO(50, 151, 399, 50),
                            width: 1.0,
                          ),
                        ),
                        child: BotaoSwitch(
                          texto: 'Tipo controle',
                          valorBotao: _tipoControle,
                          onClick: (value) {
                            setState(() {
                              _tipoControle = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                      child: Container(
                        // margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          border: Border.all(
                            color: const Color.fromRGBO(50, 151, 399, 50),
                            width: 1.0,
                          ),
                        ),
                        child: BotaoSwitch(
                          texto: 'Status',
                          valorBotao: _status,
                          onClick: (value) {
                            setState(() {
                              _status = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void salvar(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _setupValidacao.validarUmidades(
        _umidadeMaxima,
        _umidadeMinima,
      );
      _formKey.currentState!.save();
      Setup _setup = Setup(
        status: _status,
        tipoControle: _tipoControle,
        umidadeMaxima: _umidadeMaxima,
        umidadeMinima: _umidadeMinima,
      );
      Cultura cultura = Cultura(
        nome: _nomeCultura,
        setup: _setup,
      );
      _culturaService
          .createCultura(cultura)
          .then((culturaCriada) => {Navigator.pop(context)});
    }
  }
}
