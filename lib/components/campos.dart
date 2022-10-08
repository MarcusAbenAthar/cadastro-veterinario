import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CampoTexto extends StatelessWidget {
  CampoTexto({
    Key? key,
    required this.etiqueta,
    required this.tamanho,
    this.controlador,
    required this.habilitado,
    this.formatadores,
    this.aoDigitar,
    this.aoEnviar,
  }) : super(key: key);
  TextEditingController? controlador;
  final String etiqueta;
  final bool habilitado;
  final int tamanho;
  final ValueChanged? aoDigitar;
  List<TextInputFormatter>? formatadores;
  final VoidCallback? aoEnviar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: TextFormField(
        enabled: habilitado,
        onEditingComplete: aoEnviar,
        inputFormatters: formatadores,
        onChanged: aoDigitar,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controlador,
        decoration: InputDecoration(
          labelText: etiqueta,
          labelStyle: const TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        maxLength: tamanho,
      ),
    );
  }
}
