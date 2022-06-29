import 'dart:convert';

import 'package:http/http.dart';

import '../models/agendamento.dart';
import 'webclients/webclient.dart';

class AgendamentoService {
  final Client _client = Webclient().client;

  Future<Agendamento> criarAgendamento(Agendamento agendamento) async {
    var response = await _client.post(
      Uri.parse('${Webclient.baseUrl}agendamento'),
      headers: <String, String>{
        'Content-type': 'application/json ; charset=UTF-8',
      },
      body: jsonEncode(agendamento.toJson()),
    );

    if (response.statusCode == 200) {
      return Agendamento.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao criar cultura");
    }
  }

  Future<List<Agendamento>> listarAgendamentos(int culturaId) async {
    Response response = await _client
        .get(Uri.parse('${Webclient.baseUrl}agendamento/$culturaId'));

    if (response.statusCode == 200) {
      final List<dynamic> corpoDaRequisicao = jsonDecode(response.body);

      return corpoDaRequisicao
          .map((json) => Agendamento.fromJson(json))
          .toList();
    } else {
      throw Exception("Erro ao listar agendamentos");
    }
  }

  Future<Response> deletarAgendamento(int id) async {
    Response response = await _client.delete(
      Uri.parse('${Webclient.baseUrl}agendamento/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: id.toString(),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Erro ao deletar agendamento");
    }
  }

  Future<Response> deletarAgendamentoPorCulturaId(int culturaId) async {
    Response response = await _client.delete(
      Uri.parse(
          '${Webclient.baseUrl}agendamento/deletarAgendamentos/$culturaId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: culturaId.toString(),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Erro ao deletar agendamentos da cultura $culturaId");
    }
  }
}
