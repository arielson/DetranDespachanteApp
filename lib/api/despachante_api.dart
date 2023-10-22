import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/despachante.dart';
import '../utilities.dart';

class DespachanteApi {
  static String controller = 'Despachante';

  static Future<Despachante> getClienteByLoginAndSenha(String login, String senha) async {
    var url = Utilities.url + 'v1/';
    final response =
    await http.get(Uri.parse('$url$controller/GetByLoginAndSenha/$login/$senha'));
    if (response.statusCode == 200) {
      return Despachante.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
