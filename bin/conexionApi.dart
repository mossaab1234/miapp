import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PokemonService {
mostrarInfo() async {
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
  }

comparar() async {
    stdout.write("Primer Pokémon: ");
    String? poke1 = stdin.readLineSync();
    stdout.write("Segundo Pokémon: ");
    String? poke2 = stdin.readLineSync();

    if (poke1 != null && poke2 != null && poke1.isNotEmpty && poke2.isNotEmpty) {
      var resp1 = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/${poke1.toLowerCase()}"));
      var resp2 = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/${poke2.toLowerCase()}"));

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
    }
  }

descripcion() async {
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
  }
}
