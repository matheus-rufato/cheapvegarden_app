import 'setup.dart';

class Cultura {
  int? id;
  String? nome;
  int? controleId;
  Setup? setup;

  Cultura({this.id, this.nome, this.controleId, this.setup});

  Cultura.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        nome = json["nome"] as String,
        controleId = json["controleId"] as int,
        setup = Setup.fromJson(json["setup"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "controleId": controleId,
        "setupDto": setup!.toJson()
      };
}
