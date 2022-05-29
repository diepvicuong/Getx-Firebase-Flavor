import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../utils/logger.dart';

class StorageService {
  static final _storageRef = FirebaseStorage.instance.ref();

  static Future<File?> _compressImage(String photoId, File image) async {
    final tempDirection = await getTemporaryDirectory();
    final path = tempDirection.path;
    File? compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImage;
  }

  static Future<String?> uploadProfileImage(File imageFile) async {
    final uniquePhotoId = Uuid().v4();

    try {
      File? image = await _compressImage(uniquePhotoId, imageFile);

      if (image != null) {
        UploadTask uploadTask = _storageRef
            .child('images/users/userProfile_$uniquePhotoId.jpg')
            .putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e, s) {
      MyLogger.d(e.toString());
      // throw DSException('internal_server_error', exception: e, stack: s);
    }

    return null;
  }
}
