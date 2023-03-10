import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<dynamic> saveCurrentUser(String data) async {
    return await _storage.write(key: 'currentUser', value: data);
  }

  Future<dynamic> getCurrentUser() async {
    return await _storage.read(key: 'currentUser');
  }

  Future<dynamic> removeAll() async {
    return await _storage.deleteAll();
  }
}
