import 'dart:convert';

import 'package:cheapvegarden_app/models/cultura_leitura.dart';
import 'package:http/http.dart';

import '../models/cultura.dart';
import 'webclients/webclient.dart';

class CulturaService {
  final Client _client = Webclient().client;

  Future<List<CulturaLeitura>> read() async {
    Response response =
        await _client.get(Uri.parse('${Webclient.baseUrl}/cultura'));

    if (response.statusCode == 200) {
      final List<dynamic> corpoDaRequisicao =
          jsonDecode(utf8.decode(response.bodyBytes));
      return corpoDaRequisicao
          .map((json) => CulturaLeitura.fromJson(json))
          .toList();
    } else {
      throw Exception("Erro ao listar culturas");
    }
  }

  Future<CulturaLeitura> listarCulturaPorSetup(int setupId) async {
    Response response = await _client.get(
      Uri.parse('${Webclient.baseUrl}/cultura/buscarPorSetup/$setupId'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return CulturaLeitura.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Erro ao listar culturas");
    }
  }

  Future<CulturaLeitura> createCultura(Cultura cultura) async {
    var response = await _client.post(
      Uri.parse('${Webclient.baseUrl}/cultura'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
      body: jsonEncode(cultura.toJson()),
    );

    if (response.statusCode == 200) {
      return CulturaLeitura.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao criar cultura");
    }
  }

  Future<String> alterarNomeDaCultura(CulturaLeitura culturaLeitura) async {
    Response response = await _client.put(
      Uri.parse('${Webclient.baseUrl}/cultura/${culturaLeitura.id}'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
      body: culturaLeitura.nome,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Erro ao criar cultura");
    }
  }

  Future<Response> deletarCultura(int id) async {
    Response response = await _client.delete(
      Uri.parse('${Webclient.baseUrl}/cultura/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: id.toString(),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Falhou ao deletar cultura');
    }
  }
}
