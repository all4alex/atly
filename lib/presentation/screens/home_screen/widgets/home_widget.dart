// import 'package:atly/presentation/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:fluttericon/font_awesome_icons.dart';

// import '../../../core/constants/strings.dart';

// import 'package:flutter/material.dart';

// class MessageScreen extends StatefulWidget {
//   const MessageScreen({super.key});

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// void _handlePressed(types.User otherUser, BuildContext context) async {
//   final room = await FirebaseChatCore.instance.createRoom(otherUser);

//   // Navigate to the Chat screen
// }

// class _MessageScreenState extends State<MessageScreen> {
//   bool _pinned = true;
//   bool _snap = false;
//   bool _floating = false;

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<List<types.User>>(
//       stream: FirebaseChatCore.instance.users(),
//       initialData: const [],
//       builder: (context, snapshot) {
//         List<types.User> chatUsers = [];
//         if (snapshot.connectionState == ConnectionState.done ||
//             snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }
//           if (snapshot.hasData) {
//             chatUsers = snapshot.data!;
//             print(chatUsers);
//             return CustomScrollView(
//               slivers: <Widget>[
//                 SliverAppBar(
//                   pinned: true,
//                   snap: false,
//                   floating: false,
//                   expandedHeight: 160.0,
//                   flexibleSpace: FlexibleSpaceBar(
//                     title: Text('SliverAppBar'),
//                     background: FlutterLogo(),
//                   ),
//                   leading: IconButton(
//                     icon: Icon(Icons.menu),
//                     tooltip: 'Go to the next page',
//                     onPressed: () {},
//                   ),
//                   actions: [
//                     IconButton(
//                       icon: Icon(Icons.search),
//                       tooltip: 'Show Snackbar',
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.chat_rounded),
//                       tooltip: 'Go to the next page',
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 SliverToBoxAdapter(
//                   child: InkWell(
//                     onTap: () async {
//                       await FirebaseAuth.instance.signOut().then((value) =>
//                           Navigator.of(context, rootNavigator: true)
//                               .pushReplacement(LoginScreen.route()));
//                     },
//                     child: SizedBox(
//                       height: 20,
//                       child: Center(
//                         child:
//                             Text('Scroll to see the SliverAppBar in effect.'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       types.User chatUser = chatUsers[index];
//                       return InkWell(
//                           onTap: () async {
//                             _handlePressed(chatUser, context);
//                           },
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               // Display the Flutter Logo image asset.
//                               foregroundImage:
//                                   NetworkImage('${chatUser.imageUrl}'),
//                             ),
//                             title: Text(
//                               '${chatUser.firstName} ${chatUser.lastName}',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleSmall!
//                                   .copyWith(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                   ),
//                             ),
//                             subtitle: Text(
//                               'online',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelSmall!
//                                   .copyWith(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                   ),
//                             ),
//                             trailing: IconButton(
//                                 onPressed: () {}, icon: Icon(Icons.more_horiz)),
//                           ));
//                     },
//                     childCount: chatUsers.length,
//                   ),
//                 ),
//               ],
//             );
//           }
//         }
//         return const CircularProgressIndicator();
//       },
//     ));
//   }
// }
