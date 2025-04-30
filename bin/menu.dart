import 'package:mysql1/mysql1.dart';

connectDB() async {
  var settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    db: 'contabilidad_db',
  );
  return await MySqlConnection.connect(settings);
}


loginUser(String nombre, String password) async {
  var conn = await connectDB();
  try {
    var result = await conn.query(
      "SELECT * FROM usuarios WHERE nombre = ? AND password = ?",
      [nombre, password]
    );
    return result.isNotEmpty;
  } catch (e) {
    print("Error en la consulta: $e");
    return false;
  } finally {
    await conn.close();
  }
}



registerUser(String nombre, String password) async {
  var conn = await connectDB();
  try {
    var result = await conn.query(
      "SELECT * FROM usuarios WHERE nombre = ?",
      [nombre]
    );
    if (result.isNotEmpty) {
      print("El usuario ya existe, prueba con otro");
    } else {
      await conn.query(
        "INSERT INTO usuarios(nombre, password) VALUES (?, ?)",
        [nombre, password]
      );
      print("Usuario registrado en la base de datos");
    }
  } catch (e) {
    print("Error al registrar usuario");
  } finally {
    await conn.close();
  }
}

registrarCliente(String dni, String direccion, String email, String telefono) async {
  var conn = await connectDB();
  try {
    var result = await conn.query(
      "SELECT * FROM clientes WHERE dni = ?",
      [dni]
    );
    if (result.isNotEmpty) {
      print("El usuario ya existe, prueba con otro");
    } else {
      await conn.query(
        "INSERT INTO clientes (dni, direccion, email, telefono) VALUES (?, ?, ?, ?)",
        [dni, direccion, email, telefono]
      );
      print("Cliente registrado en la base de datos");
    }
  } catch (e) {
    print("Error al registrar el cliente: $e");
  } finally {
    await conn.close();
  }
}