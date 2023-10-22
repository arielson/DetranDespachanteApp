import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

import '../utilities.dart';

class PdfPage extends StatefulWidget {
  final String filePath;
  final String fileName;

  const PdfPage({Key? key, required this.filePath, required this.fileName}) : super(key: key);

  @override
  _PdfPage createState() => _PdfPage();
}

class _PdfPage extends State<PdfPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Padding(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final box = context.findRenderObject() as RenderBox?;
                      List<String> paths = [widget.filePath];
                      await Share.shareFiles(paths,
                          text: widget.fileName,
                          subject: 'DESPATI - ' + widget.fileName,
                          sharePositionOrigin:
                          box!.localToGlobal(Offset.zero) & box.size);
                    },
                    child: const Text('COMPARTILHAR')),
                Expanded(
                  child: PDFView(
                    filePath: widget.filePath,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    onRender: (_pages) {
                      setState(() {
                        pages = _pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      // print(error.toString());
                    },
                    onPageError: (page, error) {
                      // print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onPageChanged: (int? page, int? total) {
                      // print('page change: $page/$total');
                    },
                  ),
                )
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: Text('${Utilities.appName} - ' + widget.fileName),
    );
  }
}
