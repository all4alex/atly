import 'package:atly/src/app/app_colors.dart';
import 'package:flutter/material.dart';

class ChatAttachementModal extends StatelessWidget {
  final Function onPressedButton1;
  final Function onPressedButton2;
  final Function onPressedButton3;

  ChatAttachementModal({
    required this.onPressedButton1,
    required this.onPressedButton2,
    required this.onPressedButton3,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCircleIconButton(
            icon: Icons.image,
            onPressed: onPressedButton1,
          ),
          SizedBox(height: 8),
          _buildCircleIconButton(
            icon: Icons.attach_file_outlined,
            onPressed: onPressedButton2,
          ),
          SizedBox(height: 8),
          _buildCircleIconButton(
            icon: Icons.cancel,
            onPressed: onPressedButton3,
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton(
      {required IconData icon, required Function onPressed}) {
    return InkResponse(
      onTap: () => onPressed(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
