import 'package:flutter/material.dart';

import '../../screens/controle_screen.dart';
import '../../screens/cultura_list_screen.dart';
import '../../screens/log_screen.dart';
import '../../screens/setup_screen.dart';

// ignore: must_be_immutable
class BarraNavegacao extends StatefulWidget {
  int selectedIndex;

  BarraNavegacao(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao> {
  final List<Widget> _telas = [
    const ControleScreen(),
    const SetupScreen(),
    const CulturaListScreen(),
    const LogScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.thermostat_rounded),
            label: 'Umidity',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: 'Setup',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.eco_outlined),
            label: 'Culture',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.graphic_eq_outlined),
            label: 'Log',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }
}
