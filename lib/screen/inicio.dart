import 'package:cadastro_veterinario/model/animal_model.dart';
import 'package:cadastro_veterinario/provider/cadastro_provider.dart';
import 'package:cadastro_veterinario/repository/animal_repository.dart';
import 'package:cadastro_veterinario/screen/atualizar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
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

  void _deletarAnimal(int index) {
    AnimalCadastrado animalCadastrado =
        Provider.of<AnimalCadastrado>(context, listen: false);
    animalCadastrado.deletarAnimal(animais[index]);
    _alimentarLista();
  }

  void _alerta(String nome, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Ação")),
          content: Text("Você deseja excluir ou editar o $nome?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    child: const Text("Excluir"),
                    onPressed: () {
                      _deletarAnimal(index);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text('Sucesso'),
                              ),
                              content: const Text('Excluido com sucesso'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/home');
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          });
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text("Editar"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaAtualizarAnimal(
                            title: 'Atualizar Animal', idAnimal: index),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

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
      body: Consumer<AnimalCadastrado>(
          builder: (context, animalCadastrado, child) {
        if (animais.isEmpty) {
          return Center(
            child: Text(
              'Não há animais cadastrados.',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
              ),
            ),
          );
        } else {
          return ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: null,
                  ),
                  title: Text(
                    animais[index].nome,
                  ),
                  subtitle: Text(
                    animais[index].nomeDono,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.error_outline_sharp,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    onPressed: () {
                      final int posicao = animais.indexOf(animais[index]);
                      _alerta(animais[index].nome, posicao);
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: animais.length,
          );
        }
      }),
    );
  }
}
