import 'package:image_picker/image_picker.dart';

class PhotoCaptureService {
  Future<XFile?> capturePhoto() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }
}
