import 'dart:convert';

import 'package:despati/api/despachante_api.dart';
import 'package:despati/helpers/page_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loginAgente()
              ],
            )));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(Utilities.appName),
    );
  }

  final _textEditingControllerLogin = TextEditingController();
  final _textEditingControllerSenha = TextEditingController();

  TextFormField textFormFieldLogin() {
    return TextFormField(
      controller: _textEditingControllerLogin,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o E-mail';
        }

        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: 'E-mail'),
    );
  }

  bool passwordVisible = false;

  TextFormField textFormFieldSenha() {
    return TextFormField(
      controller: _textEditingControllerSenha,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o Senha';
        }

        if (value.length < 6) {
          return 'Senha inválida';
        }

        return null;
      },
      obscureText: !passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: 'Senha'),
    );
  }

  Widget loginAgente() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('Login do Despachante', style: TextStyle(color: Colors.black, fontSize: 20)),
          textFormFieldLogin(),
          textFormFieldSenha(),
          TextButton(onPressed: () async {
            if (_formKey.currentState!.validate()) {
              alertDialogLoading(context);
              var senha = Utilities.convertSHA256(_textEditingControllerSenha.text);
              var email = _textEditingControllerLogin.text;
              DespachanteApi.getClienteByLoginAndSenha(email, senha).then((value) async {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: 'Bem vindo(a) ${value.nome}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0
                );
                final SharedPreferences prefs = await _prefs;
                prefs.setString('usuario', jsonEncode(value));

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              }).catchError((error) {
                Navigator.pop(context);
                alertDialog('Erro', error, context);
              });
            }
          },
              child: const Text('ACESSAR', style: TextStyle(fontSize: 18)))
        ],
      ),
    );
  }
}