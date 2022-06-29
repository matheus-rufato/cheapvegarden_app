import 'package:cheapvegarden_app/models/agendamento.dart';
import 'package:cheapvegarden_app/models/cultura_leitura.dart';
import 'package:cheapvegarden_app/screens/agendamento_form_screen.dart';
import 'package:cheapvegarden_app/services/agendamento_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/widgets/cartao_lista.dart';
import '../components/widgets/mensagem_erro.dart';
import '../components/widgets/progress.dart';
import '../components/widgets/remover_cartao.dart';
import '../components/widgets/titulo_screen.dart';

class AgendamentoListScreen extends StatefulWidget {
  final CulturaLeitura culturaLeitura;

  const AgendamentoListScreen({
    Key? key,
    required this.culturaLeitura,
  }) : super(key: key);

  @override
  State<AgendamentoListScreen> createState() => _AgendamentoListScreenState();
}

class _AgendamentoListScreenState extends State<AgendamentoListScreen> {
  final AgendamentoService _agendamentoService = AgendamentoService();
  List<Agendamento> agendamentos = [];

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
      body: FutureBuilder<List<Agendamento>>(
        future:
            _agendamentoService.listarAgendamentos(widget.culturaLeitura.id!),
        builder: (context, AsyncSnapshot<List<Agendamento>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                agendamentos = snapshot.data!;
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                      child: TituloScreen(texto: 'agendamentos'),
                    ),
                    Flexible(
                      child: Container(
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
                        child: agendamentos.isNotEmpty
                            ? ListView.builder(
                                itemCount: agendamentos.length,
                                itemBuilder: (context, index) {
                                  final Agendamento agendamento =
                                      agendamentos[index];
                                  String horaInicioFormated = DateFormat()
                                      .add_Hm()
                                      .format(agendamento.horaInicial!);
                                  String horaFimFormated = DateFormat()
                                      .add_Hm()
                                      .format(agendamento.horaFim!);
                                  return RemoverCartao(
                                    object: agendamento,
                                    objects: agendamentos,
                                    index: index,
                                    cartao: CartaoLista(
                                      titulo: horaInicioFormated,
                                      icone: Icon(
                                        Icons.schedule_rounded,
                                        color: Colors.green.shade700,
                                      ),
                                      subtitulo: horaFimFormated,
                                      onClick: () {},
                                    ),
                                    onDismissible: (direction) {
                                      setState(() {
                                        _agendamentoService.deletarAgendamento(
                                            agendamento.id!);
                                        agendamentos.removeAt(index);
                                      });
                                    },
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  "Nenhum agendamento cadastrado",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            heroTag: const Text('form'),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => AgendamentoFormScreen(
                                    agendamentosListados: agendamentos,
                                    culturaLeitura: widget.culturaLeitura,
                                  ),
                                ),
                              )
                                  .then((agendamentoCriado) {
                                setState(() {
                                  widget.createState();
                                });
                              });
                            },
                            child: const Icon(Icons.more_time),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: agendamentos.isNotEmpty
                              ? FloatingActionButton(
                                  heroTag: const Text('apagar'),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title:
                                            const Text('Excluir agendamentos'),
                                        content: const Text(
                                          'Deseja excluir todos os agendamentos?',
                                          style: TextStyle(fontSize: 24.0),
                                        ),
                                        elevation: 2.0,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                              'CANCELAR',
                                            ),
                                            child: const Text('CANCELAR'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _agendamentoService
                                                      .deletarAgendamentoPorCulturaId(
                                                          widget.culturaLeitura
                                                              .id!);
                                                  agendamentos.clear();
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.clear_sharp),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const MensagemErro(
                  message: "Sem conexão com servidor",
                  icon: Icons.warning_amber,
                );
              }
          }
          return const MensagemErro(
            message: 'Unknown error',
            icon: Icons.error_outline,
          );
        },
      ),
    );
  }
}
