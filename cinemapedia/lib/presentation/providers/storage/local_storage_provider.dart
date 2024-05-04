import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tendremos luego un provider de Riverpod en la que vamos a tener creada la instancia de LocalStorageRepositoryImpl
final localStorageRepositoryProvider = Provider((ref) => LocalStorageRepositoryImpl(IsarDatasource()));
