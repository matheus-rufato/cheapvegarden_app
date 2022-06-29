class CulturaLeitura {
  int? id;
  String? nome;
  int? controleId;
  int? setupId;

  CulturaLeitura({this.id, this.nome, this.controleId, this.setupId});

  CulturaLeitura.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nome = json["nome"],
        controleId = json["controleId"],
        setupId = json["setupId"];

  Map<String, dynamic> toJson() =>
      {"id": id, "nome": nome, "controleId": controleId, "setupId": setupId};
}
