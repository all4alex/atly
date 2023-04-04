import 'package:atly/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AtlyPasswordField extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  final Function(String?)? onSaved;
  const AtlyPasswordField({
    Key? key,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  State<AtlyPasswordField> createState() => _AtlyPasswordFieldState();
}

class _AtlyPasswordFieldState extends State<AtlyPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.remove_red_eye_rounded
                  : Icons.remove_red_eye_outlined,
              size: 26,
              color: AppColors.iconGrey,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}
