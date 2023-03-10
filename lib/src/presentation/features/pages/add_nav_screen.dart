import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddNavScreen extends StatefulWidget {
  const AddNavScreen({super.key});

  @override
  State<AddNavScreen> createState() => _AddNavScreenState();
}

class _AddNavScreenState extends State<AddNavScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AddNavScreen'),
      ),
    );
  }
}

void showEditModal(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final TextStyle textStyle1 = Theme.of(context).textTheme.headline1!;
  showMaterialModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
      height: screenSize.height * .2,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
      child: Column(
        children: <Widget>[
          Container(
            child: Text('asdasdasd'),
          )
        ],
      ),
    ),
  );
}
