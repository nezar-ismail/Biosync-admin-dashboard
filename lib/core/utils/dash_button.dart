// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, deprecated_member_use, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashButton extends StatelessWidget {
  DashButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color,
      required this.icon});

  Color color;

  final VoidCallback onPressed;

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shadowColor: MaterialStateProperty.all(Colors.black),
            overlayColor: MaterialStateProperty.all(Colors.greenAccent),
            padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
          ),
          label: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.sizeOf(context).width / 100,
            ),
          )),
    );
  }
}
