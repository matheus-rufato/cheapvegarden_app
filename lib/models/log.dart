import 'package:intl/intl.dart';

class Log {
  int? id;
  DateTime? hora;
  DateTime? data;
  double? fluxo;
  double? temperaturaClima;
  double? umidadeClima;
  double? umidadeSolo;

  Log(
      {this.id,
      this.hora,
      this.fluxo,
      this.temperaturaClima,
      this.umidadeClima,
      this.umidadeSolo});

  Log.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        hora = DateFormat.Hms().parse(json["hora"]),
        data = DateFormat("yyyy-MM-dd").parse(json["data"]),
        fluxo = json["fluxo"],
        temperaturaClima = json["temperaturaClima"],
        umidadeClima = json["umidadeClima"],
        umidadeSolo = json["umidadeSolo"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "hora": DateFormat().add_Hm().format(hora!),
        "data": DateFormat().add_yMd().format(data!),
        "fluxo": fluxo,
        "temperaturaClima": temperaturaClima,
        "umidadeClima": umidadeClima,
        "umidadeSolo": umidadeSolo
      };
}
