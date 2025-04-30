// ignore: file_names
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


listarClientes() async {
  var conn = await connectDB(); 
  try {
    var resultados = await conn.query("SELECT * FROM clientes");

    if (resultados.isEmpty) {
      print("No hay clientes registrados");
    } else {
      int contador = 1;
      for (var fila in resultados) {
        print("Cliente $contador:");
        print("DNI: ${fila['dni']}");
        print("Dirección: ${fila['direccion']}");
        print("Email: ${fila['email']}");
        print("Teléfono: ${fila['telefono']}");
        contador++; 
      }
    }
  } catch (e) {
    print("Error al listar los clientes: $e");
  } finally {
    await conn.close();
  }
}



clientes() async {
  var conn = await connectDB();
  try {
    await conn.query("""CREATE TABLE  IF NOT EXISTS clientes (
    dni VARCHAR(20) PRIMARY KEY,
    direccion VARCHAR(255),
    email VARCHAR(100),
    telefono VARCHAR(20)
      );""");
    print("Tabla clientes creada");
  } catch (e) {
    print("Error al configurar la base de datos: $e");
  } finally {
    await conn.close();
  }
}
