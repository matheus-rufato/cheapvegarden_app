import 'package:cheapvegarden_app/components/widgets/barra_navegacao.dart';
import 'package:cheapvegarden_app/components/widgets/botao_switch.dart';
import 'package:cheapvegarden_app/components/widgets/campo_texto_formulario.dart';
import 'package:cheapvegarden_app/components/widgets/texto_setup.dart';
import 'package:cheapvegarden_app/components/widgets/titulo_screen.dart';
import 'package:cheapvegarden_app/models/cultura_leitura.dart';
import 'package:cheapvegarden_app/models/setup.dart';
import 'package:cheapvegarden_app/services/cultura_service.dart';
import 'package:cheapvegarden_app/services/setup_service.dart';
import 'package:flutter/material.dart';

import '../validators/setup_validacao.dart';

class CulturaFormUpdateScreen extends StatefulWidget {
  final Setup setup;
  final CulturaLeitura? culturaLeitura;

  const CulturaFormUpdateScreen({
    Key? key,
    required this.setup,
    this.culturaLeitura,
  }) : super(key: key);

  @override
  State<CulturaFormUpdateScreen> createState() =>
      _CulturaFormUpdateScreenState();
}

class _CulturaFormUpdateScreenState extends State<CulturaFormUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetupService _setupService = SetupService();
  final CulturaService _culturaService = CulturaService();
  final SetupValidacao _setupValidacao = SetupValidacao();

  late int? _umidadeMaxima;
  late int? _umidadeMinima;
  String? _textoVerificacaoMinimo;
  String? _textoVerificacaoMaximo;

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
              _salvar(context);
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
              child: TituloScreen(texto: 'editar'),
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
                      child: widget.culturaLeitura?.nome != null
                          ? CampoTextoFormulario(
                              label: 'Cultura',
                              icone: Icon(
                                Icons.label,
                                color: Colors.green.shade900,
                              ),
                              teclado: TextInputType.text,
                              habilitar: true,
                              textoInicial: widget.culturaLeitura!.nome!,
                              sufixo: const Text('%'),
                              validar: (valor) {
                                if (valor == null || valor.isEmpty) {
                                  return 'Campo obrigatório!';
                                }
                                return null;
                              },
                              salvar: (valor) {
                                widget.culturaLeitura!.nome = valor;
                              },
                              clicar: null,
                            )
                          : const TextoSetup(
                              texto: 'Setup',
                              icone: Icon(
                                Icons.label,
                                color: Colors.blue,
                              ),
                            ),
                    ),
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
                        textoInicial: '${widget.setup.umidadeMinima}',
                        sufixo: const Text('%'),
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
                        salvar: (valor) {
                          widget.setup.umidadeMinima = int.parse(valor);
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
                        textoInicial: '${widget.setup.umidadeMaxima}',
                        sufixo: const Text('%'),
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
                        salvar: (valor) {
                          setState(() {
                            widget.setup.umidadeMaxima = int.parse(valor);
                          });
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
                          valorBotao: widget.setup.tipoControle!,
                          onClick: (value) {
                            setState(() {
                              widget.setup.tipoControle = value;
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
                        child: widget.setup.id! > 1
                            ? BotaoSwitch(
                                texto: 'Status',
                                valorBotao: widget.setup.status!,
                                onClick: (value) {
                                  setState(() {
                                    widget.setup.status = value;
                                  });
                                },
                              )
                            : null,
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

  void _salvar(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Setup setupAlterado = widget.setup;
      CulturaLeitura culturaLeituraAlterado =
          widget.culturaLeitura ?? CulturaLeitura();
      _formKey.currentState!.save();
      if (widget.culturaLeitura?.nome != null) {
        _culturaService.alterarNomeDaCultura(culturaLeituraAlterado);
        _setupService.alterar(setupAlterado).then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => BarraNavegacao(1)),
                  (route) => false),
            });
      } else {
        _setupService
            .alterar(setupAlterado)
            .then((value) => {Navigator.pop(context)});
      }
    }
  }
}
