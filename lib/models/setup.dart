class Setup {
  int? id;
  bool? status;
  bool? tipoControle;
  int? umidadeMaxima;
  int? umidadeMinima;

  Setup(
      {this.id,
      this.status,
      this.tipoControle,
      this.umidadeMaxima,
      this.umidadeMinima});

  Setup.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"],
        tipoControle = json["tipoControle"],
        umidadeMaxima = json["umidadeMaxima"],
        umidadeMinima = json["umidadeMinima"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "tipoControle": tipoControle,
        "umidadeMaxima": umidadeMaxima,
        "umidadeMinima": umidadeMinima
      };
}
