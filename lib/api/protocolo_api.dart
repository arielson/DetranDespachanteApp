import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/despachante.dart';
import '../models/protocolo.dart';
import '../utilities.dart';

class ProtocoloApi {
  static String controller = 'ProtocoloDetran';
  static final Future<SharedPreferences> _prefs =
  SharedPreferences.getInstance();

  static Future<Protocolo> concluirServico(Protocolo item) async {
    final SharedPreferences prefs = await _prefs;
    var despachanteJson = prefs.getString('usuario');
    Despachante despachante = Despachante.fromJson(jsonDecode(despachanteJson!));

    var url = Utilities.url + 'v1/';
    var protocolo = jsonEncode(item);
    final response =
    await http.post(Uri.parse('$url$controller/ConcluirServico'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${despachante.token}'
        },
        body: protocolo);
    if (response.statusCode == 200) {
      return Protocolo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<Protocolo>> consultarServicos(String placa) async {
    final SharedPreferences prefs = await _prefs;
    var despachanteJson = prefs.getString('usuario');
    Despachante despachante = Despachante.fromJson(jsonDecode(despachanteJson!));

    var url = Utilities.url + 'v1/';
    final response =
    await http.get(Uri.parse('$url$controller/ConsultarServicos/$placa'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${despachante.token}'
        });
    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return List<Protocolo>.from(items.map((model) => Protocolo.fromJson(model)));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Protocolo> consultarServico(int numeroProtcolo) async {
    final SharedPreferences prefs = await _prefs;
    var despachanteJson = prefs.getString('usuario');
    Despachante despachante = Despachante.fromJson(jsonDecode(despachanteJson!));

    var url = Utilities.url + 'v1/';
    final response =
    await http.get(Uri.parse('$url$controller/ConsultarServico/$numeroProtcolo'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${despachante.token}'
        });
    if (response.statusCode == 200) {
      return Protocolo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Uint8List> pdf(String filename) async {
    final SharedPreferences prefs = await _prefs;
    var despachanteJson = prefs.getString('usuario');
    Despachante despachante = Despachante.fromJson(jsonDecode(despachanteJson!));

    var url = Utilities.url + 'v1/';
    final response =
    await http.get(Uri.parse('$url$controller/PDF/$filename'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${despachante.token}'
        });
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception(response.body);
    }
  }
}
