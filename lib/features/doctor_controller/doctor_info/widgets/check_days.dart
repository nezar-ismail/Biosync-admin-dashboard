// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:admin/core/models/doctor_model.dart';
import 'package:admin/features/doctor_controller/doctor_info/widgets/days_container.dart';

import 'package:flutter/material.dart';

class ListDays extends StatelessWidget {
  const ListDays({
    Key? key,
    required this.doctor,
  });
  final DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Work Days: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.textScalerOf(context).textScaleFactor * 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < doctor.workday!.length; i++)
                DaysContainer(
                  i: i,
                  doctor: doctor,
                ),
            ],
          )
        ],
      ),
    );
  }
}
