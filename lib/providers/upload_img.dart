// Saving profile pictures to the firebase storage
import 'dart:io';

import '../public_packages.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

Future<String> storeFileToStorage(String ref, File file) async {
  UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
