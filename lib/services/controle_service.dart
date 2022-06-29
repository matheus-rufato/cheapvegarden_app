import 'dart:convert';

import 'package:http/http.dart';

import '../models/controle.dart';
import 'webclients/webclient.dart';

class ControleService {
  final Client _client = Webclient().client;

  Future<bool> readStatusSolenoide() async {
    final Response response = await _client
        .get(Uri.parse('${Webclient.baseUrl}controle/lerStatusSolenoide'));

    if (response.statusCode == 200) {
      bool statusSolenoide = jsonDecode(response.body);
      return statusSolenoide;
    } else {
      throw Exception("Erro ao trazer status da solenoide");
    }
  }

  Stream<Controle> readRealtime() async* {
    while (true) {
      await Future.delayed(const Duration(microseconds: 500));
      final Response response =
          await _client.get(Uri.parse('${Webclient.baseUrl}controle'));

      if (response.statusCode == 200) {
        yield Controle.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Erro ao trazer os dados de controle");
      }
    }
  }

  Future<Response> alterarStatusSolenoide(bool statusSolenoide) async {
    // var json = jsonEncode(<String, bool>{'statusSolenoide': statusSolenoide});

    Response response = await _client.put(
      Uri.parse('${Webclient.baseUrl}/controle/alterarStatusSolenoide'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
      body: "$statusSolenoide",
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Erro ao alterar cultura");
    }
  }
}
