import 'package:flutter/material.dart';

import '../../app/app.dart';

class BxtraSimpleTimePicker extends StatefulWidget {
  const BxtraSimpleTimePicker({required this.onSelected});
  final Function(TimeOfDay) onSelected;

  @override
  State<BxtraSimpleTimePicker> createState() => _BxtraSimpleTimePickerState();
}

class _BxtraSimpleTimePickerState extends State<BxtraSimpleTimePicker> {
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
          width: screenSize.width * .4,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              border: Border.all(color: AppColors.appGrey),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              )),
          child: selectedTime == null
              ? dateEmpty(screenSize)
              : dateNotEmpty(screenSize)),
    );
  }

  Widget dateEmpty(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('--:-- --',
                style: TextStyle(
                  color: AppColors.appBlack,
                  fontSize: screenSize.height * .017,
                )),
            SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/clock_icon.png'))
          ],
        )
      ],
    );
  }

  Widget dateNotEmpty(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${selectedTime!.format(context)}',
                style: TextStyle(
                  color: AppColors.appBlack,
                  fontSize: screenSize.height * .017,
                )),
            SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/clock_icon.png'))
          ],
        )
      ],
    );
  }

  void openDatePicker(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime ??
          TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
        widget.onSelected(selectedTime!);
      });
    }
  }
}
