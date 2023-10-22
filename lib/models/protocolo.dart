class Protocolo {
  String numeroProtocolo;
  String foto;
  String nomeServicoPrincipal;
  String origem;
  String status;
  String fase;
  String cpfCnpj;
  String placa;
  String renavam;
  String chassi;
  String servicos;
  String pagamentos;
  String documentos;
  String drpdf;
  String crvpdf;
  String crlVePDF;
  bool isiOS;

  Protocolo(
      {required this.numeroProtocolo,
      required this.foto,
      required this.nomeServicoPrincipal,
      required this.origem,
      required this.status,
      required this.fase,
      required this.placa,
      required this.chassi,
      required this.cpfCnpj,
      required this.renavam,
      required this.servicos,
      required this.pagamentos,
      required this.documentos,
      required this.drpdf,
      required this.crvpdf,
      required this.crlVePDF,
      required this.isiOS});

  factory Protocolo.fromJson(Map<String, dynamic> json) {
    return Protocolo(
        numeroProtocolo: json['numeroProtocolo'] ?? '',
        foto: json['foto'] ?? '',
        origem: json['origem'] ?? '',
        status: json['status'] ?? '',
        fase: json['fase'] ?? '',
        cpfCnpj: json['cpfCnpj'] ?? '',
        placa: json['placa'] ?? '',
        renavam: json['renavam'] ?? '',
        chassi: json['chassi'] ?? '',
        servicos: json['servicos'] ?? '',
        nomeServicoPrincipal: json['nomeServicoPrincipal'] ?? '',
        pagamentos: json['pagamentos'] ?? '',
        documentos: json['documentos'] ?? '',
        drpdf: json['drpdf'] ?? '',
        crvpdf: json['crvpdf'] ?? '',
        crlVePDF: json['crlVePDF'] ?? '',
        isiOS: json['isiOS'] ?? false);
  }

  Map<String, dynamic> toJson() => {
        'numeroProtocolo': numeroProtocolo,
        'foto': foto,
        'nomeServicoPrincipal': nomeServicoPrincipal,
        'origem': origem,
        'status': status,
        'fase': fase,
        'cpfCnpj': cpfCnpj,
        'placa': placa,
        'renavam': renavam,
        'chassi': chassi,
        'servicos': servicos,
        'pagamentos': pagamentos,
        'documentos': documentos,
        'drpdf': drpdf,
        'crvpdf': crvpdf,
        'crlVePDF': crlVePDF,
        'isiOS': isiOS
      };
}
