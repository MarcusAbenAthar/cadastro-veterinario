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
          0xFF153e19,
          {
            50: Color(0xFF2D562E),
            100: Color(0xFF2D562E),
            200: Color(0xFF456E45),
            300: Color(0xFF5E885D),
            400: Color(0xFF77A276),
            500: Color(0xFF91BD90),
            600: Color(0xFFACD9AA),
            700: Color(0xFFC8F6C5),
            800: Color(0xFFE4FFE2),
            900: Color(0xFFFFFFFE)
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
