import 'package:cheapvegarden_app/models/agendamento.dart';

class AgendamentoValidacao {
  String? validarAgendamento(
    DateTime horaInicio,
    DateTime horaFim,
    List<Agendamento> agendamentos,
  ) {
    DateTime horaInicioMaisDuas = horaInicio.add(const Duration(hours: 2));

    if (horaFim.compareTo(horaInicio) == 0) {
      return 'Hora de início igual hora de fim do agendamento';
    }
    if (horaInicioMaisDuas.compareTo(horaFim) < 0) {
      return 'Agendamento maior do que 2 horas';
    }

    for (Agendamento agendamento in agendamentos) {
      DateTime horaInicioMenos29 =
          agendamento.horaInicial!.subtract(const Duration(minutes: 29));
      DateTime horaFimMais29 =
          agendamento.horaFim!.add(const Duration(minutes: 29));

      if (!((horaInicio.isAfter(horaFimMais29)) !=
          (horaFim.isBefore(horaInicioMenos29)))) {
        return 'Intervalo menor do que 30min no agendamento';
      }
    }
    return null;
  }
}
