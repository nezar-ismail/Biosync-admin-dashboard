// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextAbout extends StatelessWidget {
  TextAbout({super.key, required this.myController});
  TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200),
      child: TextField(
        controller: myController,
        maxLines: 10,
        style: const TextStyle(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade50,
          hintText: 'About',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
