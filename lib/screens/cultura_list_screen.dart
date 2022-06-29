import 'package:cheapvegarden_app/components/widgets/cartao_lista.dart';
import 'package:cheapvegarden_app/components/widgets/progress.dart';
import 'package:cheapvegarden_app/components/widgets/remover_cartao.dart';
import 'package:cheapvegarden_app/models/cultura_leitura.dart';
import 'package:cheapvegarden_app/models/setup.dart';
import 'package:cheapvegarden_app/screens/cultura_form_create_screen.dart';
import 'package:cheapvegarden_app/screens/cultura_form_update_screen.dart';
import 'package:cheapvegarden_app/services/cultura_service.dart';
import 'package:cheapvegarden_app/services/setup_service.dart';
import 'package:flutter/material.dart';

import '../components/widgets/mensagem_erro.dart';
import '../components/widgets/titulo_screen.dart';

class CulturaListScreen extends StatefulWidget {
  const CulturaListScreen({Key? key}) : super(key: key);

  @override
  State<CulturaListScreen> createState() => _CulturaListScreenState();
}

class _CulturaListScreenState extends State<CulturaListScreen> {
  late final CulturaService _culturaService = CulturaService();
  final SetupService _setupService = SetupService();
  late Setup setup;

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
      body: FutureBuilder<List<CulturaLeitura>>(
        future: _culturaService.read(),
        builder: (context, AsyncSnapshot<List<CulturaLeitura>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<CulturaLeitura> culturas = snapshot.data!;

                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                      child: TituloScreen(texto: 'culturas'),
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
                        child: culturas.isNotEmpty
                            ? ListView.builder(
                                itemCount: culturas.length,
                                itemBuilder: (context, index) {
                                  final CulturaLeitura culturaLeitura =
                                      culturas[index];
                                  return RemoverCartao(
                                    object: culturaLeitura,
                                    objects: culturas,
                                    index: index,
                                    cartao: CartaoLista(
                                      titulo: culturaLeitura.nome!,
                                      icone: Icon(
                                        Icons.agriculture_rounded,
                                        color: Colors.green.shade700,
                                      ),
                                      subtitulo: null,
                                      onClick: () async {
                                        setup =
                                            await _setupService.lerSetupPorId(
                                                culturaLeitura.setupId!);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CulturaFormUpdateScreen(
                                              setup: setup,
                                              culturaLeitura: culturaLeitura,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    onDismissible: (direction) {
                                      setState(() {
                                        _culturaService
                                            .deletarCultura(culturaLeitura.id!);
                                        culturas.removeAt(index);
                                      });
                                    },
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  "Nenhuma cultura cadastrada",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      const CulturaFormCreateScreen()))
                              .then((culturaCriada) {
                            setState(
                              () {
                                widget.createState();
                              },
                            );
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
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
