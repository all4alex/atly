// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   Future<bool> updateSession({required User? user}) async {
//     String data = user.toString();
//   bool  SharedPreferences.getInstance()
//         .then((SharedPreferences value) => user != null
//             ? value.setString(
//                 'currentUser',
//                 data,
//               )
//             : (value) => Future.any());
//   }

//   Future<String?> getCurrentSession() async {
//     return await SharedPreferences.getInstance()
//         .then((SharedPreferences value) => value.getString('currentUser'));
//   }
// }
