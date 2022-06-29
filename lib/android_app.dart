import 'package:cheapvegarden_app/components/widgets/barra_navegacao.dart';
import 'package:cheapvegarden_app/screens/controle_screen.dart';
import 'package:cheapvegarden_app/screens/log_screen.dart';
import 'package:flutter/material.dart';

import 'screens/setup_screen.dart';
import 'screens/splash.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cheapvegarden",
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(142, 215, 206, 10),
        ).copyWith(
          secondary: Colors.greenAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent[700],
          ),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Colors.green.shade600,
            fontFamily: 'Open Sans',
            fontSize: 32.0,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => const Splash(),
        '/barraNavegacao': (context) => BarraNavegacao(0),
        '/controle': (context) => const ControleScreen(),
        '/log': (context) => const LogScreen(),
        '/setup': (context) => const SetupScreen(),
      },
      initialRoute: '/splash',
    );
  }
}
