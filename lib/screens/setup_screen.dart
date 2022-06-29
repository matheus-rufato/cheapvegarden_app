import 'package:cheapvegarden_app/components/widgets/botao_switch.dart';
import 'package:cheapvegarden_app/components/widgets/mensagem_erro.dart';
import 'package:cheapvegarden_app/components/widgets/progress.dart';
import 'package:cheapvegarden_app/screens/agendamento_list_screen.dart';
import 'package:cheapvegarden_app/services/controle_service.dart';
import 'package:cheapvegarden_app/services/setup_service.dart';
import 'package:flutter/material.dart';

import '../components/widgets/texto_setup.dart';
import '../components/widgets/titulo_screen.dart';
import '../models/cultura_leitura.dart';
import '../models/setup.dart';
import '../services/cultura_service.dart';
import 'cultura_form_update_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final SetupService _setupService = SetupService();
  final CulturaService _culturaService = CulturaService();
  final ControleService _controleService = ControleService();
  CulturaLeitura? culturaLeitura;

  @override
  void initState() {
    culturaLeitura = CulturaLeitura();
    super.initState();
  }

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
      ),
      body: FutureBuilder<Setup>(
        future: _setupService.read(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                Setup setup = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
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
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: setup.id! > 1
                                    ? FutureBuilder<CulturaLeitura>(
                                        future: _culturaService
                                            .listarCulturaPorSetup(setup.id!),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return const MensagemErro(
                                                message:
                                                    'Sem conexão com servidor',
                                                icon: Icons.warning_amber,
                                              );

                                            case ConnectionState.waiting:
                                              return const Progress();

                                            case ConnectionState.active:
                                              break;
                                            case ConnectionState.done:
                                              culturaLeitura = snapshot.data!;
                                              return TituloScreen(
                                                  texto: culturaLeitura!.nome!);
                                          }

                                          return const MensagemErro(
                                            message: 'Unknown error',
                                            icon: Icons.error,
                                          );
                                        },
                                      )
                                    : const TituloScreen(texto: 'setup'),
                              ),
                              TextoSetup(
                                texto: 'Umidade Mínima: ${setup.umidadeMinima}',
                                icone: const Icon(
                                  Icons.water_drop_outlined,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              TextoSetup(
                                texto: 'Umidade Máxima: ${setup.umidadeMaxima}',
                                icone: const Icon(
                                  Icons.water_drop_sharp,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (!setup.tipoControle!)
                                      FutureBuilder<bool>(
                                        future: _controleService
                                            .readStatusSolenoide(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            bool statusSolenoide =
                                                snapshot.data!;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(15.0),
                                                  ),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        50, 151, 399, 50),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: BotaoSwitch(
                                                  texto: 'Irrigação manual',
                                                  valorBotao: statusSolenoide,
                                                  onClick: (value) {
                                                    setState(() {
                                                      statusSolenoide = value;
                                                      _controleService
                                                          .alterarStatusSolenoide(
                                                        statusSolenoide,
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                          return const Progress();
                                        },
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                            border: Border.all(
                                              color: const Color.fromRGBO(
                                                  50, 151, 399, 50),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Irrigação automática',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FloatingActionButton(
                                            heroTag: const Text(
                                              'Editar',
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CulturaFormUpdateScreen(
                                                    setup: setup,
                                                    culturaLeitura:
                                                        culturaLeitura ??
                                                            CulturaLeitura(),
                                                  ),
                                                ),
                                              )
                                                  .then(
                                                (value) {
                                                  setState(
                                                    () {
                                                      widget.createState();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child:
                                                const Icon(Icons.edit_outlined),
                                            elevation: 8.0,
                                            enableFeedback: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: setup.id! > 1
                                              ? FloatingActionButton(
                                                  heroTag: const Text(
                                                    'Agendamento',
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgendamentoListScreen(
                                                                culturaLeitura:
                                                                    culturaLeitura!),
                                                      ),
                                                    );
                                                  },
                                                  child: const Icon(
                                                      Icons.schedule_rounded),
                                                  elevation: 8.0,
                                                  enableFeedback: true,
                                                )
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const MensagemErro(
                  message: 'Sem conexão com servidor',
                  icon: Icons.warning_amber_rounded,
                );
              }
          }
          return const MensagemErro(
            message: 'Unknown error',
            icon: Icons.error,
          );
        },
      ),
    );
  }
}
