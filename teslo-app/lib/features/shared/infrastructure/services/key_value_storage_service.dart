
// Quiero que sea abstracta porque si luego cambiamos la implementación, debe 
// tener que seguir cumpliendo estas reglas.
abstract class KeyValueStorageService {

  // Esto ahora queda dynamic, pero vamos a usar genéricos para resolverlo
  Future<void> setKeyValue(String key, dynamic value);
  Future getValue(String key, dynamic value);
  Future<bool> removeKey(String key);

}
