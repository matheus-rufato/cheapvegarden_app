import 'package:cheapvegarden_app/models/cultura_leitura.dart';
import 'package:cheapvegarden_app/services/agendamento_service.dart';
import 'package:cheapvegarden_app/validators/agendamento_validacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/widgets/titulo_screen.dart';
import '../models/agendamento.dart';

class AgendamentoFormScreen extends StatefulWidget {
  final List<Agendamento> agendamentosListados;
  final CulturaLeitura culturaLeitura;

  const AgendamentoFormScreen({
    Key? key,
    required this.agendamentosListados,
    required this.culturaLeitura,
  }) : super(key: key);

  @override
  State<AgendamentoFormScreen> createState() => _AgendamentoFormScreenState();
}

class _AgendamentoFormScreenState extends State<AgendamentoFormScreen> {
  final AgendamentoValidacao _agendamentoValidacao = AgendamentoValidacao();
  final AgendamentoService _agendamentoService = AgendamentoService();

  // DateTime horaInicio = DateTime.now();
  late String? horaInicio;
  late String? horaFim;

  late Agendamento agendamento;
  late DateTime? horaInicioConvertida;
  late DateTime? horaFimConvertida;
  String? validacao;

  TimeOfDay? _hora;
  TimeOfDay? horaSelecionada;

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    horaSelecionada = (await showTimePicker(
      context: context,
      initialTime: _hora ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      useRootNavigator: true,
      hourLabelText: 'Hora',
      minuteLabelText: 'Minuto',
      // confirmText:
    ));
    return horaSelecionada;
  }

  @override
  void initState() {
    _hora = TimeOfDay.now();
    horaInicio = '';
    horaFim = '';
    agendamento = Agendamento();
    horaInicioConvertida = DateTime.now();
    horaFimConvertida = DateTime.now();
    validacao = null;
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
        actions: [
          IconButton(
            onPressed: () {
              validar(context);
            },
            icon: const Icon(Icons.check_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: TituloScreen(texto: 'agendamento'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hora Início: $horaInicio',
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              _hora = await selectTime(context);
                              setState(() {
                                horaInicio = _hora != null
                                    ? _hora?.format(context).toString()
                                    : '';
                                _hora != null
                                    ? horaInicioConvertida =
                                        DateFormat.Hm().parse(horaInicio!)
                                    : null;
                                // horaInicio = horaInicioConvertida.
                              });
                            },
                            icon: const Icon(Icons.schedule_rounded),
                            iconSize: 40,
                            focusColor: Colors.greenAccent,
                            hoverColor: Colors.green,
                            highlightColor: Colors.lightGreenAccent,
                            splashRadius: 24.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hora Fim: $horaFim',
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              _hora = await selectTime(context);
                              setState(() {
                                horaFim = _hora != null
                                    ? _hora?.format(context).toString()
                                    : '';
                                _hora != null
                                    ? horaFimConvertida =
                                        DateFormat.Hm().parse(horaFim!)
                                    : null;
                                // horaInicio = horaInicioConvertida.
                              });
                            },
                            icon: const Icon(Icons.schedule_rounded),
                            iconSize: 40,
                            focusColor: Colors.greenAccent,
                            hoverColor: Colors.green,
                            highlightColor: Colors.lightGreenAccent,
                            splashRadius: 24.0,
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
      ),
    );
  }

  void validar(BuildContext context) {
    if (horaInicio!.isNotEmpty && horaFim!.isNotEmpty) {
      validacao = null;
      validacao = _agendamentoValidacao.validarAgendamento(
          horaInicioConvertida!,
          horaFimConvertida!,
          widget.agendamentosListados);
      if (validacao != null) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Erro ao criar agendamento'),
            content: Text(
              '$validacao',
              style: const TextStyle(fontSize: 24.0),
            ),
            elevation: 2.0,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        _salvar(context);
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro ao criar agendamento'),
          content: const Text(
            'Adicione horarios',
            style: TextStyle(fontSize: 24.0),
          ),
          elevation: 2.0,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _salvar(BuildContext context) {
    agendamento.culturaId = widget.culturaLeitura.id;
    agendamento.horaInicial = horaInicioConvertida;
    agendamento.horaFim = horaFimConvertida;
    _agendamentoService
        .criarAgendamento(agendamento)
        .then((agendamentoCriado) => {Navigator.pop(context)});
  }
}
