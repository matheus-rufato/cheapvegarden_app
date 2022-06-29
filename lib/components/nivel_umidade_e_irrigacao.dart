import 'package:cheapvegarden_app/components/widgets/titulo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class NivelUmidadeEIrrigacao extends StatelessWidget {
  final bool? irrigacao;
  final double nivelUmidade;

  const NivelUmidadeEIrrigacao({
    Key? key,
    this.irrigacao,
    required this.nivelUmidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          child: TituloScreen(texto: 'Umidade do Solo'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FAProgressBar(
                    animatedDuration: const Duration(milliseconds: 900),
                    direction: Axis.vertical,
                    backgroundColor: Colors.black87,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    size: 64,
                    verticalDirection: VerticalDirection.up,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.blueAccent,
                    ),
                    progressColor: Colors.lightBlueAccent,
                    // currentValue: model.umidadeSolo!.toDouble(),
                    currentValue: double.parse(nivelUmidade.toStringAsFixed(2)),
                    displayText: '%',
                    displayTextStyle: const TextStyle(
                      //color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Text(
                    '$nivelUmidade %',
                    style: const TextStyle(
                      fontSize: 48,
                      fontFamily: 'OpenSans',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              text: 'Irrigação: ',
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                (irrigacao == true)
                    ? const TextSpan(
                        text: 'ON',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : const TextSpan(
                        text: ' OFF',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
