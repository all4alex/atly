import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    String imageURL = '';

    if (image != null) {
      Reference ref = _storage.ref().child('images/${DateTime.now()}.png');
      UploadTask uploadTask = ref.putFile(image);
      await uploadTask.then((res) async {
        imageURL = await res.ref.getDownloadURL();
      });
    }
    return imageURL;
  }

  Future<File> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    return File(imageFile!.path);
  }
}
