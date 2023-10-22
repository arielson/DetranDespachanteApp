import 'package:despati/helpers/page_helper.dart';
import 'package:despati/models/protocolo.dart';
import 'package:despati/pages/protocolo_detalhe_page.dart';
import 'package:flutter/material.dart';
import '../api/protocolo_api.dart';
import '../utilities.dart';

class ProtocoloListaPage extends StatefulWidget {
  final List<Protocolo> protocolos;
  final String placa;

  const ProtocoloListaPage({Key? key, required this.protocolos, required this.placa})
      : super(key: key);

  @override
  _ProtocoloListaPage createState() => _ProtocoloListaPage();
}

class _ProtocoloListaPage extends State<ProtocoloListaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width - 50,
              child: listView()),
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: Text('${Utilities.appName} - Placa: ${widget.placa}'),
    );
  }

  ListView listView() {
    return ListView.separated(
      itemCount: widget.protocolos.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(widget.protocolos[index].numeroProtocolo),
                  subtitle: Text(widget.protocolos[index].origem),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('DETALHES'),
                      onPressed: () {
                        alertDialogLoading(context);
                        ProtocoloApi.consultarServico(
                            int.parse(widget.protocolos[index].numeroProtocolo))
                            .then((value) {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProtocoloDetalhePage(protocolo: value)));
                        }).catchError((error) {
                          Navigator.pop(context);
                          alertDialog('Erro', error, context);
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    // TextButton(
                    //   child: const Text('LISTEN'),
                    //   onPressed: () {/* ... */},
                    // ),
                    // const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.transparent,
        thickness: 1.5,
      ),
    );
  }
}
