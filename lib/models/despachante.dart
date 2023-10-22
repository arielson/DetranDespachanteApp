class Despachante {
  int id;
  String nome;
  String token;

  Despachante({
    required this.id,
    required this.nome,
    required this.token
  });

  factory Despachante.fromJson(Map<String, dynamic> json) {
    return Despachante(
        id: json['id'],
        nome: json['nome'],
        token: json['token']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'token': token
  };
}