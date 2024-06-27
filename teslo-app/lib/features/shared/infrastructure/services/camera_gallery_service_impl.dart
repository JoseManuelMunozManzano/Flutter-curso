// Implementando el patrón adaptador.
// Fuera de este archivo, en ningún lugar nos debe hacer falta importar image_picker.
import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    // Por eso se devuelve un String opcional, porque puede devolver null.
    if (photo == null) return null;

    print('Tenemos una imagen ${photo.path}');

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    // Por eso se devuelve un String opcional, porque puede devolver null.
    if (photo == null) return null;

    print('Tenemos una imagen ${photo.path}');

    return photo.path;
  }

}
