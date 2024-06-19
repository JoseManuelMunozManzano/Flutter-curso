
// Quiero que sea abstracta porque si luego cambiamos la implementación, debe 
// tener que seguir cumpliendo estas reglas.
abstract class KeyValueStorageService {

  // Usamos genéricos para resolver el tipo de dato dynamic que habíamos puesto
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);

}
