import 'dart:convert';

import 'package:cheapvegarden_app/models/setup.dart';
import 'package:cheapvegarden_app/services/webclients/webclient.dart';
import 'package:http/http.dart';

class SetupService {
  final Client _client = Webclient().client;

  Future<Setup> read() async {
    final Response response;
    response = await _client.get(
      Uri.parse('${Webclient.baseUrl}setup'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Setup.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao trazer os dados de controle");
    }
  }

  Future<Setup> lerSetupPorId(int setupId) async {
    final Response response;
    response = await _client.get(
      Uri.parse('${Webclient.baseUrl}setup/$setupId'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Setup.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao trazer os dados de controle");
    }
  }

  Future<Setup> alterar(Setup setup) async {
    var response = await _client.put(
      Uri.parse('${Webclient.baseUrl}setup/${setup.id}'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
      body: jsonEncode(setup.toJson()),
    );

    if (response.statusCode == 200) {
      return Setup.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao editar setup");
    }
  }
}
