import 'dart:convert';
import 'dart:io';

import 'package:despati/api/protocolo_api.dart';
import 'package:despati/pages/protocolo_lista_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/page_helper.dart';
import '../models/protocolo.dart';
import '../utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: widgetsEstabelecimento()));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(Utilities.appName),
    );
  }

  SingleChildScrollView widgetsEstabelecimento() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                child: ElevatedButton(
                    onPressed: () async {
                      showPlateDialog(context);
                    },
                    child: const Text(
                      'CONSULTAR SERVIÇOS',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    )),
                width: double.infinity,
                height: 140,
              ),
              const Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () async {
                      showImageDialog(context);
                    },
                    child: const Text(
                      'CONCLUIR SERVIÇO',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    )),
                width: double.infinity,
                height: 140,
              ),
              const Padding(padding: EdgeInsets.all(20)),
            ],
          )
        ],
      ),
    );
  }

  final _textEditingProtocoloController = TextEditingController();

  Future<void> showImageDialog(BuildContext context) async {
    _textEditingProtocoloController.text = '';
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: const Text("Qual o número do Protocolo?",
                        style: TextStyle(fontSize: 17)),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  TextFormField(
                      controller: _textEditingProtocoloController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe o Protocolo";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Número do Protocolo"))
                ],
              )),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    if (_textEditingProtocoloController.text.isNotEmpty) {
                      Fluttertoast.showToast(
                          msg:
                              'Para validar a conclusão tire uma selfie com o aparelho na vertical.\nEnquadre o rosto no centro da foto.',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 4,
                          fontSize: 16.0);
                      final pickedImage = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                          maxWidth: 480,
                          maxHeight: 480,
                          preferredCameraDevice: CameraDevice.front);

                      if (pickedImage == null) return;
                      alertDialogLoading(context);
                      var bytes = await pickedImage.readAsBytes();
                      String foto = base64.encode(bytes);

                      var protocolo = Protocolo(
                          numeroProtocolo: _textEditingProtocoloController.text,
                          foto: foto,
                          renavam: '',
                          placa: '',
                          origem: '',
                          cpfCnpj: '',
                          chassi: '',
                          status: '',
                          fase: '',
                          servicos: '',
                          documentos: '',
                          nomeServicoPrincipal: '',
                          pagamentos: '',
                          drpdf: '',
                          crvpdf: '',
                          crlVePDF: '',
                          isiOS: Platform.isIOS);

                      ProtocoloApi.concluirServico(protocolo).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        alertDialog(
                            'Aviso', 'Serviço concluído com sucesso!', context);
                      }).catchError((error) {
                        Navigator.pop(context);
                        alertDialog('Erro', error, context);
                      });
                    } else {
                      alertDialog(
                          'Erro', 'Digite o Protocolo corretamente', context);
                    }
                  },
                ),
                TextButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }

  final _textEditingPlacaController = TextEditingController();

  Future<void> showPlateDialog(BuildContext context) async {
    _textEditingPlacaController.text = '';
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: const Text("Qual a placa do veículo?",
                        style: TextStyle(fontSize: 17)),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  TextFormField(
                      controller: _textEditingPlacaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe a Placa";
                        }

                        if (value.length != 7) {
                          return "Informe a Placa corretamente";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      textAlign: TextAlign.left,
                      maxLength: 7,
                      decoration: const InputDecoration(hintText: "Placa"))
                ],
              )),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    if (_textEditingPlacaController.text.isNotEmpty) {
                      alertDialogLoading(context);
                      ProtocoloApi.consultarServicos(
                              _textEditingPlacaController.text)
                          .then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProtocoloListaPage(protocolos: value, placa: _textEditingPlacaController.text)));
                      }).catchError((error) {
                        Navigator.pop(context);
                        alertDialog('Erro', error, context);
                      });
                    } else {
                      alertDialog(
                          'Erro', 'Digite a Placa corretamente', context);
                    }
                  },
                ),
                TextButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }
}
