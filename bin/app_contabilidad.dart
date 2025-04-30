
import "dart:io";
import "menu.dart";
import "Cliente.dart";
import "dataBase.dart";

main() async {
  await setupDatabase();
  await clientes();
  bool logueado = false;

  do {
    stdout.writeln(""" Bienvenido, ¿qué quieres hacer?:
    1. Iniciar sesión
    2. Registrarme""");
    int opcion = int.parse(stdin.readLineSync() ?? "0");

    if (opcion == 1) {
      stdout.writeln("Introduce tu nombre de usuario");
      String nombre = stdin.readLineSync() ?? "error";
      stdout.writeln("Introduce tu contraseña");
      String password = stdin.readLineSync() ?? "error";
       if (await loginUser(nombre, password)) {
        stdout.writeln("Login correcto");
        logueado = true;
          
          
          stdout.writeln(""" Bienvenido, ¿qué quieres hacer?:
            1. Registrar clientes
            2. Listar clientes
            """);
            int opcion = int.parse(stdin.readLineSync() ?? "0");
               if (opcion == 1) {
                  stdout.writeln("Introduce el dni");
                  String dni = stdin.readLineSync() ?? "error";
                  stdout.writeln("Introduce la direccion");
                  String direccion = stdin.readLineSync() ?? "error";
                  stdout.writeln("Introduce el email");
                  String email = stdin.readLineSync() ?? "error";
                  stdout.writeln("Introduce el telefono");
                  String telefono = stdin.readLineSync() ?? "error";
                 await registrarCliente(dni, direccion, email, telefono);
               }
               if (opcion == 2) {
                do{
                  await listarClientes();
                }while(!logueado);
               }else{
                 stdout.writeln("no hay clientes");
               }
            } else {
                stdout.writeln("Login incorrecto");
      }
    } else if (opcion == 2) {
      stdout.writeln("Introduce tu nombre de usuario");
      String nombre = stdin.readLineSync() ?? "error";
      stdout.writeln("Introduce tu contraseña");
      String password = stdin.readLineSync() ?? "error";
      await registerUser(nombre, password);
    }
  } while (!logueado);

}







