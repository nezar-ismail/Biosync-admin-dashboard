// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:admin/core/models/doctor_model.dart';

import 'package:flutter/material.dart';

class ReviewsInfo extends StatelessWidget {
  final DoctorModel doctor;
  const ReviewsInfo({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Reviews
        ///
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.10,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize:
                      MediaQuery.textScalerOf(context).textScaleFactor * 20,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                overflow: TextOverflow.fade,
                maxLines: 1,
                doctor.averageRating.toString()[0] +
                    doctor.averageRating.toString()[1] +
                    doctor.averageRating.toString()[2],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),

        ///Divider
        ///
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          child: const VerticalDivider(
            indent: 10,
            endIndent: 10,
            color: Colors.black12,
            thickness: 2.0,
          ),
        ),

        ///Experience
        ///
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.10,
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.textScalerOf(context).textScaleFactor * 20,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              doctor.experience.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
