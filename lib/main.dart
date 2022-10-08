import 'package:cadastro_veterinario/provider/cadastro_provider.dart';
import 'package:cadastro_veterinario/screen/cadastro.dart';
import 'package:cadastro_veterinario/screen/inicio.dart';
import 'package:cadastro_veterinario/utils/banco_veterinario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BancoVeterinario.initDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AnimalCadastrado(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clínica Veterinária',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF002800,
          {
            50: Color(0xFFF00000),
            100: Color(0xFF153E19),
            200: Color(0xFFF8E1D7),
            300: Color(0xFFF8E1D7),
            400: Color(0xFFF8E1D7),
            500: Color(0xFFF8E1D7),
            600: Color(0xFFF8E1D7),
            700: Color(0xFFF8E1D7),
            800: Color(0xFFF8E1D7),
            900: Color(0xFFF8E1D7)
          },
        ),
      ),
      home: const Inicio(title: 'Clínica Veterinária'),
      routes: {
        '/cadastro': (context) =>
            const TelaCadastro(title: 'Cadastro de Animais'),
        '/home': (context) => const Inicio(title: 'Clínica Veterinária'),
      },
    );
  }
}
