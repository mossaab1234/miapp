import 'dart:io';
import 'baseDatos.dart';
import 'autentificacion.dart';
import 'conexionApi.dart';

main() async {
  final dbService = DatabaseService();
  await dbService.connect();
  await dbService.createTable();

  final auth = AuthService(dbService);
  final pokeService = PokemonService();

  bool logueado = false;

  while (!logueado) {
    print("1. Iniciar sesión");
    print("2. Registrarse");
    stdout.write("Opción: ");
    String? opcion = stdin.readLineSync();

    if (opcion == "1") {
      logueado = await auth.login();
    } else if (opcion == "2") {
      await auth.register();
    } else {
      print("Opción no válida.");
    }
  }

  print("1. Ver información de un Pokémon");
  print("2. Comparar dos Pokémon");
  print("3. Ver descripción de un Pokémon");
  stdout.write("Opción: ");
  String? sub = stdin.readLineSync();

  if (sub == "1") {
    await pokeService.mostrarInfo();
  } else if (sub == "2") {
    await pokeService.comparar();
  } else if (sub == "3") {
    await pokeService.descripcion();
  } else {
    print("Opción no válida.");
  }

  await dbService.close();
}
