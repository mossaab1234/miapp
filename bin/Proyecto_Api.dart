// ignore: file_names
import "dart:io";
import "package:mysql1/mysql1.dart";
import "package:http/http.dart" as http;
import "dart:convert";

main() async {
  var settings = ConnectionSettings(
    host: "localhost",
    port: 3306,
    user: "root",
    db: "miapp_db",
  );

  late MySqlConnection conn;

  try {
    conn = await MySqlConnection.connect(settings);

    await conn.query("""
      CREATE TABLE IF NOT EXISTS usuarios (
        idusuario INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50),
        contraseña VARCHAR(10)
      )
    """);
  } catch (e) {
    print("Error conectando o creando tabla: $e");
    return;
  }

  bool logueado = false;

  while (!logueado) {
    print("1. Iniciar sesión");
    print("2. Registrarse");
    stdout.write("Opción: ");
    String? opcion = stdin.readLineSync();

    if (opcion == "1") {
      stdout.write("Usuario: ");
      String? nombre = stdin.readLineSync();
      stdout.write("Contraseña: ");
      String? pass = stdin.readLineSync();

      var resultado = await conn.query(
        "SELECT * FROM usuarios WHERE nombre = ? AND password = ?",
        [nombre, pass],
      );

      if (resultado.isNotEmpty) {
        print("Login correcto");
        logueado = true;

        print("1. Ver información de un Pokémon");
        print("2. Comparar dos Pokémon");
        print("3. Ver descripción de un Pokémon");
        stdout.write("Opción: ");
        String? sub = stdin.readLineSync();

        if (sub == "1") {
          stdout.write("Nombre del Pokémon: ");
          String? poke = stdin.readLineSync();

          if (poke != null && poke.isNotEmpty) {
            var url = "https://pokeapi.co/api/v2/pokemon/${poke.toLowerCase()}";
            var resp = await http.get(Uri.parse(url));

            if (resp.statusCode == 200) {
              var datos = jsonDecode(resp.body);
              print("Nombre: ${datos['name']}");
              print("ID: ${datos['id']}");
              print("Altura: ${datos['height']}");
              print("Peso: ${datos['weight']}");
            } else {
              print("Pokémon no encontrado.");
            }
          }

        } else if (sub == "2") {
          stdout.write("Primer Pokémon: ");
          String? poke1 = stdin.readLineSync();
          stdout.write("Segundo Pokémon: ");
          String? poke2 = stdin.readLineSync();

          if (poke1 != null && poke2 != null && poke1.isNotEmpty && poke2.isNotEmpty) {
            var url1 = "https://pokeapi.co/api/v2/pokemon/${poke1.toLowerCase()}";
            var url2 = "https://pokeapi.co/api/v2/pokemon/${poke2.toLowerCase()}";

            var resp1 = await http.get(Uri.parse(url1));
            var resp2 = await http.get(Uri.parse(url2));

            if (resp1.statusCode == 200 && resp2.statusCode == 200) {
              var datos1 = jsonDecode(resp1.body);
              var datos2 = jsonDecode(resp2.body);

              var ataque1 = datos1["stats"][1]["base_stat"];
              var ataque2 = datos2["stats"][1]["base_stat"];

              print("${datos1['name']} tiene ataque: $ataque1");
              print("${datos2['name']} tiene ataque: $ataque2");

              if (ataque1 > ataque2) {
                print("${datos1['name']} ganaría el combate.");
              } else if (ataque2 > ataque1) {
                print("${datos2['name']} ganaría el combate.");
              } else {
                print("Empate en ataque.");
              }
            } else {
              print("Uno o ambos Pokémon no fueron encontrados.");
            }
          } else {
            print("Nombres no válidos.");
          }

        } else if (sub == "3") {
          stdout.write("Nombre del Pokémon: ");
          String? poke = stdin.readLineSync();

          if (poke != null && poke.isNotEmpty) {
            var url = "https://pokeapi.co/api/v2/pokemon-species/${poke.toLowerCase()}";
            var resp = await http.get(Uri.parse(url));

            if (resp.statusCode == 200) {
              var datos = jsonDecode(resp.body);

              var descripciones = datos["flavor_text_entries"] as List;
              var descripcion = descripciones.firstWhere(
                (entry) => entry["language"]["name"] == "es",
                orElse: () => null,
              );

              if (descripcion != null) {
                print("Descripción: ${descripcion["flavor_text"].replaceAll("\n", " ").replaceAll("\f", " ")}");
              } else {
                print("No se encontró una descripción en español.");
              }
            } else {
              print("Pokémon no encontrado.");
            }
          }
        } else {
          print("Opción no válida.");
        }

      } else {
        print("Usuario o contraseña incorrectos.");
      }

    } else if (opcion == "2") {
      stdout.write("Nuevo nombre: ");
      String? nombre = stdin.readLineSync();
      stdout.write("Nueva contraseña: ");
      String? pass = stdin.readLineSync();

      var existe = await conn.query(
        "SELECT * FROM usuarios WHERE nombre = ?",
        [nombre],
      );

      if (existe.isNotEmpty) {
        print("El usuario ya existe.");
      } else {
        await conn.query(
          "INSERT INTO usuarios (nombre, password) VALUES (?, ?)",
          [nombre, pass],
        );
        print("Usuario registrado.");
      }

    } else {
      print("Opción no válida.");
    }
  }

  await conn.close();
}
