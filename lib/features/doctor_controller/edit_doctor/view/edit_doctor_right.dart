import 'package:admin/core/models/doctor_model.dart';
import 'package:admin/features/doctor_controller/edit_doctor/widgets/edit_doctor_form.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class EditDoctorRightSide extends StatelessWidget {
  const EditDoctorRightSide({super.key, required this.doctor});
  final DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.teal.shade50,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(),
                  ),
                  const WindowButtons(),
                ],
              ),
            ),
            Expanded(
                child: EditDoctorForm(
              doctor: doctor,
            ))
          ],
        ),
      ),
    );
  }
}

var buttonsColors = WindowButtonColors(
    iconNormal: const Color.fromARGB(255, 0, 0, 0),
    mouseOver: const Color.fromARGB(255, 0, 0, 0),
    mouseDown: const Color.fromARGB(255, 0, 0, 0),
    iconMouseOver: const Color.fromARGB(255, 0, 0, 0),
    iconMouseDown: const Color.fromARGB(255, 0, 0, 0));

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonsColors,
        ),
        MaximizeWindowButton(
          colors: buttonsColors,
        ),
        CloseWindowButton(
          colors: buttonsColors,
        ),
      ],
    );
  }
}
