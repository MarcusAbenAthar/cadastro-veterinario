// ignore_for_file: unnecessary_this

import 'package:cadastro_veterinario/utils/banco_veterinario.dart';

class Animal {
  late String codigo;
  late String nome;
  late String nomeDono;
  late String telefone;
  late String foto;

  Animal({
    required this.codigo,
    required this.nome,
    required this.nomeDono,
    required this.telefone,
    required this.foto,
  });
  Animal.fromJson(Map<String, dynamic> json) {
    this.codigo = json[BancoVeterinario.colunaCodigo].toString();
    this.nome = json[BancoVeterinario.colunaNome].toString();
    this.nomeDono = json[BancoVeterinario.colunaNomeDono].toString();
    this.telefone = json[BancoVeterinario.colunaTelefone].toString();
    this.foto = json[BancoVeterinario.colunaFoto].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      BancoVeterinario.colunaCodigo: codigo,
      BancoVeterinario.colunaNome: nome,
      BancoVeterinario.colunaNomeDono: nomeDono,
      BancoVeterinario.colunaTelefone: telefone,
      BancoVeterinario.colunaFoto: foto
    };
  }
}
