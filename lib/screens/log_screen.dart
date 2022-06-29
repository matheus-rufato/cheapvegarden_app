import 'package:cheapvegarden_app/components/widgets/titulo_screen.dart';
import 'package:cheapvegarden_app/services/log_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../components/widgets/mensagem_erro.dart';
import '../components/widgets/progress.dart';
import '../models/log.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  late final LogService _logService;

  late List<charts.Series<Log, int>> _seriesDadosGrafico;

  @override
  void initState() {
    _logService = LogService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _gerarDados(List<Log> listaLog) {
    _seriesDadosGrafico = <charts.Series<Log, int>>[];
    _seriesDadosGrafico.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.greenAccent),
        id: 'Fluxo',
        data: listaLog,
        domainFn: (Log log, _) => listaLog.indexOf(log),
        measureFn: (Log log, _) => log.fluxo,
      ),
    );
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
      body: StreamBuilder<List<Log>>(
        stream: _logService.listarLog(),
        builder: (context, AsyncSnapshot<List<Log>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              List<Log> listaLog = snapshot.data!;
              List<double> fluxos =
                  listaLog.map((element) => element.fluxo!).toList();
              fluxos.sort();
              double maiorFluxo = fluxos.last;

              _gerarDados(listaLog);
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TituloScreen(texto: 'Fluxo'),
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
                      child: charts.NumericComboChart(
                        _seriesDadosGrafico,
                        defaultRenderer: charts.LineRendererConfig(
                          includeArea: true,
                          stacked: true,
                          includePoints: true,
                        ),
                        animate: false,
                        animationDuration: const Duration(milliseconds: 500),
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          showAxisLine: true,
                          viewport: charts.NumericExtents(0, maiorFluxo),
                        ),
                        domainAxis: const charts.NumericAxisSpec(
                          showAxisLine: true,
                          viewport: charts.NumericExtents(0, 12),
                        ),
                        // domainAxis: new charts.EndPointsTimeAxisSpec(),
                        behaviors: [
                          charts.ChartTitle(
                            'Fluxo (l/h)',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea,
                          ),
                          charts.ChartTitle(
                            'Ultimos 12 registro',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const MensagemErro(
                  message: "Sem conexão com servidor",
                  icon: Icons.warning_amber,
                );
              }
              break;
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
