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



setupDatabase() async {
  var conn = await connectDB();
  try {
    await conn.query("""CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        password VARCHAR(10) NOT NULL
      );""");
    print("Tabla usuarios creada");
  } catch (e) {
    print("Error al configurar la base de datos: $e");
  } finally {
    await conn.close();
  }
}