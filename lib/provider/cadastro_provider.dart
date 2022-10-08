import 'package:cadastro_veterinario/model/animal_model.dart';
import 'package:cadastro_veterinario/repository/animal_repository.dart';
import 'package:flutter/material.dart';

class AnimalCadastrado with ChangeNotifier {
  static void getCadastro(int index) {
    lerAnimal(index.toString());
  }

  static lerAnimal(String codigo) {
    return AnimalRepository.getAnimal(codigo);
  }

  void inserirAnimal(Animal animal) {
    AnimalRepository.addAnimal(animal);
    notifyListeners();
  }

  static lerTodosAnimais() {
    AnimalRepository.getAllData();
  }

  void deletarAnimal(Animal animal) {
    AnimalRepository.deleteAnimal(animal);
  }

  void atualizarAnimal(Animal animal) {
    AnimalRepository.updateAnimal(animal);
    notifyListeners();
  }
}
