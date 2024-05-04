import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {

  // Regresamos la instancia de Isar.
  // Es late porque la apertura de una BD no es síncrona. Vamos a tener que esperar
  // que la BD esté lista antes de poder realizar cualquier tipo de trabajo.
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  // Esto no deja de ser un singleton.
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        // inspector es un servicio que Isar levanta automáticamente y sirve para analizar como está la BD local.
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    // Esperamos que nuestra BD esté lista.
    final isar = await db;

    // Siempre se sigue la fórmula siguiente: isar + esquema + lo que queremos hacer
    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movieId)
        .findFirst();
    
    // Si tiene valor lo devuelve y si es null devuelve false.
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    // Esperamos que nuestra BD esté lista.
    final isar = await db;

    // Implementada la paginación con los valores que me manden.
    // No es el objetivo del Isar Datasource saber en qué página estoy. Su objetivo
    // es, dado lo que me mandan, devolver la data.
    return isar.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {

    // Esperamos que nuestra BD esté lista.
    final isar = await db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();
    
    // Hacemos una transacción, borrar o insertar
    if (favoriteMovie != null) {
      // Borrar
      // En este punto, tengo el id de Isar.
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
