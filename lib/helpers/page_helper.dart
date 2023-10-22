import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alertDialogLoading(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

alertDialog(titulo, texto, context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(titulo),
          content: Text(texto
              .toString()
              .replaceAll('Exception:', '')
              .trim()),
          actions: <Widget>[
            TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
    },
  );
}