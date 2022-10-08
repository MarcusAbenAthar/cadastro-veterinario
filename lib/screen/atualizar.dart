// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cadastro_veterinario/components/campos.dart';
import 'package:cadastro_veterinario/model/animal_model.dart';
import 'package:cadastro_veterinario/provider/cadastro_provider.dart';
import 'package:cadastro_veterinario/repository/animal_repository.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TelaAtualizarAnimal extends StatefulWidget {
  const TelaAtualizarAnimal(
      {Key? key, required this.title, required this.idAnimal})
      : super(key: key);
  final int idAnimal;
  final String title;

  @override
  State<TelaAtualizarAnimal> createState() => _TelaAtualizarAnimalState();
}

class _TelaAtualizarAnimalState extends State<TelaAtualizarAnimal> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomeDonoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  List<Animal> animais = [];

  void _alimentarLista() async {
    List<Animal> lista = await AnimalRepository.getAllData();
    setState(() {
      animais = lista;
    });
    _nomeController.text = animais[widget.idAnimal].nome;
    _nomeDonoController.text = animais[widget.idAnimal].nomeDono;
    _telefoneController.text = animais[widget.idAnimal].telefone;
    _fotoController.text = animais[widget.idAnimal].foto;
  }

  @override
  void initState() {
    super.initState();
    _alimentarLista();
  }

  void _atualizarAnimal(int index) async {
    Animal animal = Animal(
      codigo: animais[index].codigo,
      nome: _nomeController.text,
      nomeDono: _nomeDonoController.text,
      telefone: _telefoneController.text,
      foto: _fotoController.text,
    );
    AnimalCadastrado animalCadastrado =
        Provider.of<AnimalCadastrado>(context, listen: false);
    animalCadastrado.atualizarAnimal(animal);
    Navigator.of(context).pushNamed('/home');
    // _alimentarLista();
  }

  var foneMascara = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Listar Animais',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Cadastrar Animal',
            icon: Icon(Icons.add),
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/home');
              break;
            case 1:
              Navigator.of(context).pushNamed('/cadastro');
              break;
          }
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CampoTexto(
              etiqueta: "Nome",
              habilitado: true,
              tamanho: 30,
              controlador: _nomeController,
            ),
            CampoTexto(
              etiqueta: "Nome do Dono",
              habilitado: true,
              tamanho: 50,
              controlador: _nomeDonoController,
            ),
            CampoTexto(
              etiqueta: "Telefone",
              habilitado: true,
              tamanho: 15,
              formatadores: [
                foneMascara,
              ],
              controlador: _telefoneController,
            ),
            CampoTexto(
              etiqueta: "Foto",
              habilitado: true,
              tamanho: 70,
              controlador: _fotoController,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () {
                    _atualizarAnimal(widget.idAnimal);
                  },
                  child: Text(
                    'Atualizar',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
