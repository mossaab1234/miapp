import 'dart:io';
import 'baseDatos.dart';

class AuthService {
  final DatabaseService db;

  AuthService(this.db);
login() async {
    stdout.write("Usuario: ");
    String? nombre = stdin.readLineSync();
    stdout.write("Contraseña: ");
    String? pass = stdin.readLineSync();

    var resultado = await db.login(nombre!, pass!);
    if (resultado.isNotEmpty) {
      print("Login correcto");
      return true;
    } else {
      print("Usuario o contraseña incorrectos.");
      return false;
    }
  }
register() async {
    stdout.write("Nuevo nombre: ");
    String? nombre = stdin.readLineSync();
    stdout.write("Nueva contraseña: ");
    String? pass = stdin.readLineSync();

    var existe = await db.checkUserExists(nombre!);
    if (existe.isNotEmpty) {
      print("El usuario ya existe.");
    } else {
      await db.registerUser(nombre, pass!);
      print("Usuario registrado.");
    }
  }
}
