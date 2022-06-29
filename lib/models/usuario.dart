class Usuario {
  int? id;
  String? nome;
  String? telefone;
  String? email;
  String? senha;
  String? tipo;

  Usuario(
      {this.id, this.nome, this.telefone, this.email, this.senha, this.tipo});

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nome = json["nome"],
        telefone = json["telefone"],
        email = json["email"],
        senha = json["senha"],
        tipo = json["tipo"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "telefone": telefone,
        "email": email,
        "senha": senha,
        "tipo": tipo
      };
}
