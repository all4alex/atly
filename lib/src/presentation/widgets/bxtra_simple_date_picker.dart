import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time/time.dart';

import '../../app/app.dart';
import 'bxtra_simple_time_picker.dart';

class BxtraSimpleDatePicker extends StatefulWidget {
  const BxtraSimpleDatePicker({required this.onSelected, required this.titlte});
  final Function(DateTime) onSelected;
  final String titlte;

  @override
  State<BxtraSimpleDatePicker> createState() => _BxtraSimpleDatePickerState();
}

class _BxtraSimpleDatePickerState extends State<BxtraSimpleDatePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        openDatePicker(context);
      },
      child: Container(
          height: screenSize.height * .06,
          width: screenSize.width * .42,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.appGrey),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              )),
          child: selectedDate == null
              ? dateEmpty(screenSize)
              : dateNotEmpty(screenSize)),
    );
  }

  Widget dateEmpty(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.titlte,
        ),
        SizedBox(
            width: 20,
            height: 25,
            child: Icon(
              Icons.date_range_rounded,
              color: AppColors.appMainGrey,
            ))
      ],
    );
  }

  Widget dateNotEmpty(Size screenSize) {
    return Text(
      '${_dateToFormattedString(selectedDate!)}  ',
      style: AppText.caption,
    );
  }

  void openDatePicker(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.fromDateTime(value!),
        initialEntryMode: TimePickerEntryMode.dial,
      );
      if (pickedTime != null) {
        DateTime finalDateTime = value!.copyWith(
          hour: pickedTime.hour,
          minute: pickedTime.minute,
        );
        return finalDateTime;
      } else {
        return null;
      }
    });

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.onSelected(selectedDate!);
      });
    }
  }

  String _dateToFormattedString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('MMM dd     hh:mm aaa');
    return dateFormat.format(dateTime).toString();
  }
}
