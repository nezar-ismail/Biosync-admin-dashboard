import 'package:admin/core/models/doctor_model.dart';
import 'package:flutter/material.dart';


class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [


            ///  image
            Positioned(
              top: 200,
              left: MediaQuery.sizeOf(context).width / 2 - 50,
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    'http://192.168.1.106:5000${doctor.image}',
                  )),
            ),

            ///  Name
            ///
            Positioned(
              top: 40,
              left: MediaQuery.sizeOf(context).width / 2 - 35,
              child: Text(
                doctor.doctorname,
                style: const TextStyle(
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            ///  Specialization
            ///
            Positioned(
              top: 100,
              left: 20,
              child: Text(
                doctor.specialization,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
