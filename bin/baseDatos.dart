import 'package:mysql1/mysql1.dart';

class DatabaseService {
  late MySqlConnection _conn;

connect() async {
    var settings = ConnectionSettings(
      host: "localhost",
      port: 3306,
      user: "root",
      db: "miapp_db",
    );
    _conn = await MySqlConnection.connect(settings);
  }

createTable() async {
    await _conn.query("""
      CREATE TABLE IF NOT EXISTS usuarios (
        idusuario INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50),
        password VARCHAR(10)
      )
    """);
  }

login(String nombre, String password) async {
    return await _conn.query(
      "SELECT * FROM usuarios WHERE nombre = ? AND password = ?",
      [nombre, password],
    );
  }

checkUserExists(String nombre) async {
    return await _conn.query(
      "SELECT * FROM usuarios WHERE nombre = ?",
      [nombre],
    );
  }

registerUser(String nombre, String password) async {
    await _conn.query(
      "INSERT INTO usuarios (nombre, password) VALUES (?, ?)",
      [nombre, password],
    );
  }

close() async {
    await _conn.close();
  }
}
