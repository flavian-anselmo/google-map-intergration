import 'package:flutter/material.dart';

class ReusableMapButtons extends StatelessWidget {
  ReusableMapButtons({required this.icontype, required this.onTap});
  final icontype;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.orange[100],
        child: InkWell(
          splashColor: Colors.orange,
          child: SizedBox(
            width: 36,
            height: 36,
            child: Icon(icontype),
          ),
          //todo on tap imlelment the logic of the button
          onTap: onTap,
        ),
      ),
    );
  }
}