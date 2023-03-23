// import 'package:atly/src/app/app.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class BxtraDatePicker extends StatefulWidget {
//   const BxtraDatePicker({required this.onSelected});
//   final Function(String) onSelected;

//   @override
//   State<BxtraDatePicker> createState() => _BxtraDatePickerState();
// }

// class _BxtraDatePickerState extends State<BxtraDatePicker> {
//   String dateSelected = '';
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () {
//         openDatePicker(context);
//       },
//       child: Container(
//           height: screenSize.height / 15,
//           width: screenSize.width / 1.1,
//           padding: EdgeInsets.only(left: 25),
//           decoration: BoxDecoration(
//               color: AppColors.appWhite,
//               border: Border.all(color: AppColors.appGrey),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(25),
//               )),
//           child: dateSelected.isEmpty
//               ? dateEmpty(screenSize)
//               : dateNotEmpty(screenSize)),
//     );
//   }

//   Widget dateEmpty(Size screenSize) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const SizedBox(height: 2),
//         Text('Date of birth',
//             style: TextStyle(
//               color: AppColors.appBlack,
//               fontSize: screenSize.height / 50,
//             ))
//       ],
//     );
//   }

//   Widget dateNotEmpty(Size screenSize) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text('Date of birth',
//             style: TextStyle(
//               color: AppColors.appBlack,
//               fontSize: screenSize.height / 70,
//             )),
//         const SizedBox(height: 2),
//         Text(dateSelected,
//             style: TextStyle(
//               color: AppColors.appBlack,
//               fontSize: screenSize.height / 50,
//             ))
//       ],
//     );
//   }

//   void openDatePicker(BuildContext context) {
//     FocusScopeNode currentFocus = FocusScope.of(context);

//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }
//     DatePicker.showDatePicker(context,
//         showTitleActions: true,
//         minTime: DateTime(1990, 1, 1),
//         maxTime: DateTime.now(), onChanged: (DateTime date) {
//       print('change $date');
//     }, onConfirm: (DateTime date) {
//       print('confirm $date');
//       DateFormat dateFormat = DateFormat('MM-dd-yyyy');
//       String selectedDate = dateFormat.format(date).toString();
//       widget.onSelected(selectedDate);
//       dateSelected = selectedDate;
//       setState(() {});
//     }, currentTime: DateTime.now(), locale: LocaleType.en);
//   }
// }
