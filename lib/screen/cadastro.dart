import 'package:cadastro_veterinario/components/campos.dart';
import 'package:cadastro_veterinario/model/animal_model.dart';
import 'package:cadastro_veterinario/provider/cadastro_provider.dart';
import 'package:cadastro_veterinario/repository/animal_repository.dart';
import 'package:cadastro_veterinario/screen/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomeDonoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  List<Animal> animais = [];

  @override
  void initState() {
    super.initState();
    _alimentarLista();
  }

  void _alimentarLista() async {
    List<Animal> lista = await AnimalRepository.getAllData();
    setState(() {
      animais = lista;
    });
  }

  void _cadastrar() {
    if (_nomeController.text.isNotEmpty &&
        _nomeDonoController.text.isNotEmpty &&
        _telefoneController.text.isNotEmpty) {
      Animal animal = Animal(
        codigo:
            animais.isEmpty ? 1.toString() : (animais.length + 1).toString(),
        nome: _nomeController.text,
        nomeDono: _nomeDonoController.text,
        telefone: _telefoneController.text,
        foto: _fotoController.text,
      );
      AnimalCadastrado animalCadastrado =
          Provider.of<AnimalCadastrado>(context, listen: false);
      animalCadastrado.inserirAnimal(animal);
      Navigator.of(context).pushNamed('/home');
    }
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
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: const Text("Tirar Foto"),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TelaCamera(),
                          fullscreenDialog: true))
                },
              ),
            ),
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  child: Text(
                    'Cadastrar',
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
