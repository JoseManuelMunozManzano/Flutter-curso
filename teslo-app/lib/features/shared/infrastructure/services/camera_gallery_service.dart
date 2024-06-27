// Creando patrón adaptador.
// Define las reglas que necesito para mis paquetes que vayan a usar la cámara.

abstract class CameraGalleryService {

  // Devuelve el path físico donde se encuentra la foto que acabamos de tomar.
  Future<String?> takePhoto();

  Future<String?> selectPhoto();

}
