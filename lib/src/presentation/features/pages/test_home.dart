// import 'package:flutter/material.dart';
// import 'package:flutter_animations/flutter_animations.dart';
// import 'package:parallax_image/parallax_image.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;

//   List<String> _items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 5),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: screenHeight * 1.2,
//             child: ParallaxImage(
//               image: AssetImage('assets/images/background.png'),
//               controller: _controller,
//               child: Container(
//                 color: Colors.black.withOpacity(0.5),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 20,
//             child: Text(
//               'Dashboard',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Positioned(
//             top: 100,
//             left: 20,
//             child: Text(
//               'Welcome back, John!',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           Positioned(
//             top: 150,
//             left: 20,
//             child: Text(
//               'Your account balance is \$2,500.00',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           Positioned(
//             top: 200,
//             left: 20,
//             child: Text(
//               'Recent transactions',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           Positioned(
//             top: 250,
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: ListView.builder(
//               itemCount: _items.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Dismissible(
//                   key: UniqueKey(),
//                   direction: DismissDirection.horizontal,
//                   onDismissed: (direction) {
//                     setState(() {
//                       _items.removeAt(index);
//                     });
//                   },
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   secondaryBackground: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20.0),
//                       child: Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   child: Card(
//                     child: ListTile(
//                       title: Text(_items[index]),
//                     ),
                 
