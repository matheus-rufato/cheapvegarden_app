import 'package:cheapvegarden_app/components/nivel_umidade_e_irrigacao.dart';
import 'package:cheapvegarden_app/components/widgets/mensagem_erro.dart';
import 'package:cheapvegarden_app/components/widgets/progress.dart';
import 'package:cheapvegarden_app/components/temperatura_umidade_ambiente.dart';
import 'package:cheapvegarden_app/models/controle.dart';
import 'package:cheapvegarden_app/services/controle_service.dart';
import 'package:flutter/material.dart';

class ControleScreen extends StatefulWidget {
  const ControleScreen({Key? key}) : super(key: key);

  @override
  State<ControleScreen> createState() => _ControleScreenState();
}

class _ControleScreenState extends State<ControleScreen> {
  late final ControleService _service;

  @override
  void initState() {
    _service = ControleService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: StreamBuilder<Controle>(
        stream: _service.readRealtime(),
        builder: (context, AsyncSnapshot<Controle> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    NivelUmidadeEIrrigacao(
                      irrigacao: snapshot.data!.statusSolenoide,
                      nivelUmidade: snapshot.data!.umidadeSolo!,
                    ),
                    TemperaturaUmidadeAmbiente(
                      temperaturaAmbiente: snapshot.data!.temperaturaClima,
                      umidadeAmbiente: snapshot.data!.umidadeClima,
                    ),
                  ],
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const MensagemErro(
                  message: 'Sem conexão com servidor',
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
