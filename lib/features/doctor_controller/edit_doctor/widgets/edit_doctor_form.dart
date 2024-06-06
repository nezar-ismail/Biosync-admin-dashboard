import 'dart:developer';
import 'package:admin/core/models/doctor_model.dart';
import 'package:admin/features/home/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/utils/custom_snackbar.dart';
import 'package:admin/core/utils/standerd_button.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/coustom_text_field.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/radio_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class EditDoctorForm extends StatefulWidget {
  const EditDoctorForm({super.key, required this.doctor});
  final DoctorModel doctor;
  @override
  // ignore: library_private_types_in_public_api
  _EditDoctorFormState createState() => _EditDoctorFormState();
}

class _EditDoctorFormState extends State<EditDoctorForm> {
  @override
  void initState() {
    super.initState();
    myDoctorNameController =
        TextEditingController(text: widget.doctor.doctorname);

    myDoctorSpecializationController =
        TextEditingController(text: widget.doctor.specialization);
    myDoctorExperienceController =
        TextEditingController(text: widget.doctor.experience.toString());
    myDoctorAboutController = TextEditingController(text: widget.doctor.about);
  }

  bool sunday = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;

  late TextEditingController myDoctorNameController;

  late TextEditingController myDoctorSpecializationController;
  late TextEditingController myDoctorExperienceController;
  late TextEditingController myDoctorAboutController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: Center(
            child: Text(
              'Edit Doctor',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        CustomTextField(
          hintText: widget.doctor.doctorname,
          icon: Icons.person,
          myController: myDoctorNameController,
        ),
        CustomTextField(
          hintText: widget.doctor.specialization,
          icon: Icons.school,
          myController: myDoctorSpecializationController,
        ),
        CustomTextField(
          hintText: widget.doctor.experience.toString(),
          icon: Icons.star_border,
          myController: myDoctorExperienceController,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 150),
          child: RadioButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: TextField(
              controller: myDoctorAboutController,
              maxLines: 10,
              style: const TextStyle(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade50,
                hintText: widget.doctor.about,
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
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 300, right: 300, top: 30),
            child: Builder(builder: (context) {
              return StanderButton(
                text: 'Submit',
                onPressed: () {
                  if (validateForm()) {
                    submitForm(context, widget.doctor.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Doctor Edited Successfully',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    myDoctorNameController.clear();

                    myDoctorSpecializationController.clear();
                    myDoctorExperienceController.clear();
                    myDoctorAboutController.clear();
                  }
                },
                height: 50,
                width: 150,
                fontSize: 22,
              );
            })),
      ],
    );
  }

  bool? getDayValue(int idx) {
    switch (idx) {
      case 0:
        return sunday;
      case 1:
        return monday;
      case 2:
        return tuesday;
      case 3:
        return wednesday;
      case 4:
        return thursday;
      case 5:
        return friday;
      case 6:
        return saturday;
      default:
        return false;
    }
  }

  void setDayValue(int idx, bool? value) {
    setState(() {
      switch (idx) {
        case 0:
          sunday = value ?? false;
          break;
        case 1:
          monday = value ?? false;
          break;
        case 2:
          tuesday = value ?? false;
          break;
        case 3:
          wednesday = value ?? false;
          break;
        case 4:
          thursday = value ?? false;
          break;
        case 5:
          friday = value ?? false;
          break;
        case 6:
          saturday = value ?? false;
          break;
      }
    });
  }

  bool validateForm() {
    if (myDoctorNameController.text.isEmpty ||
        myDoctorSpecializationController.text.isEmpty ||
        myDoctorExperienceController.text.isEmpty ||
        myDoctorAboutController.text.isEmpty ||
        !isNumeric(myDoctorExperienceController.text) ||
        myDoctorExperienceController.text.length > 2) {
      customSnackBar(
        context,
        title: 'Required Field',
        message: 'Please check all fields and try again.',
        type: ContentType.failure,
      );
      return false;
    }
    return true;
  }

  void submitForm(BuildContext context, int doctorId) {
    List<bool> workDays = [
      sunday,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday
    ];
    context.read<AdminCubit>().editDoctorInfo(
          id: doctorId,
          doctorname: myDoctorNameController.text,

          specialization: myDoctorSpecializationController.text,
          about: myDoctorAboutController.text,

          gender:
              genderType(), // Ensure you have this method defined or handle it properly
          experience: int.parse(myDoctorExperienceController.text),
          workdays: checkWorkDays(workDays),
        );
    // Optionally navigate back or to another page
  }

  bool isNumeric(String str) {
    return RegExp(r'^\d+$').hasMatch(str);
  }

  Map<String, dynamic> checkWorkDays(List<bool?> days) {
    List<String> daysList = [
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday'
    ];
    Map<String, dynamic> daysMap = {};
    for (int i = 0; i < daysList.length; i++) {
      if (days[i] == true) {
        daysMap[daysList[i]] = daysList[i];
      }
    }
    log(daysMap.toString());
    return daysMap;
  }
}
