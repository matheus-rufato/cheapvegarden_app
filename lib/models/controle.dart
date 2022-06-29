class Controle {
  int? id;
  double? umidadeClima;
  double? temperaturaClima;
  double? umidadeSolo;
  bool? statusSolenoide;

  Controle({
    this.id,
    this.umidadeClima,
    this.temperaturaClima,
    this.umidadeSolo,
    this.statusSolenoide,
  });

  factory Controle.fromJson(Map<String, dynamic> json) {
    return Controle(
      id: json["id"],
      umidadeClima: json["umidadeClima"],
      temperaturaClima: json["temperaturaClima"],
      umidadeSolo: json["umidadeSolo"],
      statusSolenoide: json["statusSolenoide"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "umidadeClima": umidadeClima,
        "temperaturaClima": temperaturaClima,
        "umidadeSolo": umidadeSolo,
        "statusSolenoide": statusSolenoide
      };
}
