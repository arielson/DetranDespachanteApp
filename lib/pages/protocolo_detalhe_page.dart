import 'dart:io';

import 'package:despati/pages/pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../api/protocolo_api.dart';
import '../helpers/page_helper.dart';
import '../models/protocolo.dart';
import '../utilities.dart';

class ProtocoloDetalhePage extends StatefulWidget {
  final Protocolo protocolo;

  const ProtocoloDetalhePage({Key? key, required this.protocolo})
      : super(key: key);

  @override
  _ProtocoloDetalhePage createState() => _ProtocoloDetalhePage();
}

class _ProtocoloDetalhePage extends State<ProtocoloDetalhePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titulo('Número'),
                    texto(widget.protocolo.numeroProtocolo),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Serviço Principal'),
                    texto(widget.protocolo.nomeServicoPrincipal),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Status'),
                    texto(widget.protocolo.status),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Fase'),
                    texto(widget.protocolo.fase),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('CPF/CNPJ'),
                    texto(widget.protocolo.cpfCnpj),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Placa'),
                    texto(widget.protocolo.placa),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('RENAVAM'),
                    texto(widget.protocolo.renavam),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Chassi'),
                    texto(widget.protocolo.chassi),
                    const Padding(padding: EdgeInsets.all(10)),
                    titulo('Serviço(s)'),
                    texto(widget.protocolo.servicos),
                    if (widget.protocolo.pagamentos.isNotEmpty)
                      const Padding(padding: EdgeInsets.all(10)),
                    if (widget.protocolo.pagamentos.isNotEmpty)
                      titulo('Pagamentos'),
                    if (widget.protocolo.pagamentos.isNotEmpty)
                      texto(widget.protocolo.pagamentos),
                    if (widget.protocolo.documentos.isNotEmpty)
                      const Padding(padding: EdgeInsets.all(10)),
                    if (widget.protocolo.documentos.isNotEmpty)
                      titulo('Documentos'),
                    if (widget.protocolo.documentos.isNotEmpty)
                      texto(widget.protocolo.documentos),
                    if (widget.protocolo.drpdf.isNotEmpty)
                      const Padding(padding: EdgeInsets.all(10)),
                    if (widget.protocolo.drpdf.isNotEmpty)
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                alertDialogLoading(context);
                                ProtocoloApi.pdf(widget.protocolo.drpdf)
                                    .then((value) async {
                                  final output = await getTemporaryDirectory();
                                  var filePath = '${output.path}/dr.pdf';
                                  final file = File(filePath);
                                  await file.writeAsBytes(value);
                                  Navigator.of(context).pop();
                                  if (file.existsSync()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PdfPage(
                                                  filePath: filePath,
                                                  fileName: 'DR',
                                                )));
                                  }
                                }).catchError((error) {
                                  Navigator.of(context).pop();
                                  alertDialog('Erro', error, context);
                                });
                              },
                              child: const Text('DR',
                                  style: TextStyle(fontSize: 25)))),
                    if (widget.protocolo.crlVePDF.isNotEmpty)
                      const Padding(padding: EdgeInsets.all(10)),
                    if (widget.protocolo.crlVePDF.isNotEmpty)
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                alertDialogLoading(context);
                                ProtocoloApi.pdf(widget.protocolo.crlVePDF)
                                    .then((value) async {
                                  final output = await getTemporaryDirectory();
                                  var filePath = '${output.path}/crlve.pdf';
                                  final file = File(filePath);
                                  await file.writeAsBytes(value);
                                  Navigator.of(context).pop();
                                  if (file.existsSync()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PdfPage(
                                                  filePath: filePath,
                                                  fileName: 'CRLV-e',
                                                )));
                                  }
                                }).catchError((error) {
                                  Navigator.of(context).pop();
                                  alertDialog('Erro', error, context);
                                });
                              },
                              child: const Text('CRLV-e',
                                  style: TextStyle(fontSize: 25)))),
                    if (widget.protocolo.crvpdf.isNotEmpty)
                      const Padding(padding: EdgeInsets.all(10)),
                    if (widget.protocolo.crvpdf.isNotEmpty)
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                alertDialogLoading(context);
                                ProtocoloApi.pdf(widget.protocolo.crvpdf)
                                    .then((value) async {
                                  final output = await getTemporaryDirectory();
                                  var filePath = '${output.path}/crv.pdf';
                                  final file = File(filePath);
                                  await file.writeAsBytes(value);
                                  Navigator.of(context).pop();
                                  if (file.existsSync()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PdfPage(
                                                  filePath: filePath,
                                                  fileName: 'CRV',
                                                )));
                                  }
                                }).catchError((error) {
                                  Navigator.of(context).pop();
                                  alertDialog('Erro', error, context);
                                });
                              },
                              child: const Text('CRV',
                                  style: TextStyle(fontSize: 25)))),
                  ],
                ))));
  }

  Text titulo(String texto) {
    return Text(texto, style: const TextStyle(fontSize: 25));
  }

  Text texto(String texto) {
    return Text(texto,
        style: const TextStyle(
            fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(Utilities.appName),
    );
  }
}
