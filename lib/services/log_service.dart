import 'dart:convert';

import 'package:http/http.dart';

import '../models/log.dart';
import 'webclients/webclient.dart';

class LogService {
  final Client _client = Webclient().client;

  Stream<List<Log>> listarLog() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 10));
      final Response response =
          await _client.get(Uri.parse('${Webclient.baseUrl}log/12'));

      if (response.statusCode == 200) {
        final List<dynamic> corpoDaRequisicao =
            jsonDecode(utf8.decode(response.bodyBytes));
        yield corpoDaRequisicao.map((json) => Log.fromJson(json)).toList();
      } else {
        throw Exception("Erro ao trazer os dados do Log");
      }
    }
  }
}
