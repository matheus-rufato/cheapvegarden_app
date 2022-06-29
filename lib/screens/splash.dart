import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cheapvegarden_app/components/widgets/barra_navegacao.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromRGBO(142, 215, 206, 10),
      splash: Center(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'CHEAPVEGARDEN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: BarraNavegacao(0),
    );
  }
}
