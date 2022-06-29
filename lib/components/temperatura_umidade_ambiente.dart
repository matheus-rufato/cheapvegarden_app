import 'package:cheapvegarden_app/components/widgets/titulo_screen.dart';
import 'package:flutter/material.dart';

class TemperaturaUmidadeAmbiente extends StatelessWidget {
  final double? temperaturaAmbiente;
  final double? umidadeAmbiente;

  const TemperaturaUmidadeAmbiente(
      {Key? key, this.temperaturaAmbiente, this.umidadeAmbiente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TituloScreen(texto: 'Ambiente da Estufa'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temperaturaAmbiente',
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'OpenSans',
                          color: Colors.black87,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      SizedBox(
                        width: 96,
                        height: 96,
                        child: Image.asset('assets/thermometer.png'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$umidadeAmbiente',
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'OpenSans',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 96,
                        height: 96,
                        child: Image.asset('assets/humidity.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
