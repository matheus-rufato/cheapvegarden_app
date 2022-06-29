import 'package:intl/intl.dart';

class Agendamento {
  int? id;
  int? culturaId;
  DateTime? horaInicial;
  DateTime? horaFim;

  Agendamento({this.id, this.culturaId, this.horaInicial, this.horaFim});

  Agendamento.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        culturaId = json["culturaId"],
        horaInicial = DateFormat.Hm().parse(json["horaInicio"]),
        horaFim = DateFormat.Hm().parse(json["horaFim"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "culturaId": culturaId,
        "horaInicio": DateFormat().add_Hms().format(horaInicial!),
        "horaFim": DateFormat().add_Hm().format(horaFim!)
      };
}
