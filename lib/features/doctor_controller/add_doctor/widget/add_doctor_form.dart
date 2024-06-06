import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:admin/core/utils/custom_snackbar.dart';
import 'package:admin/core/utils/standerd_button.dart';
import 'package:admin/features/doctor_controller/add_doctor/cubit/add_doctor_cubit.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/coustom_text_field.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/radio_button.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/text_about.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddDoctorForm extends StatefulWidget {
  const AddDoctorForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDoctorFormState createState() => _AddDoctorFormState();
}

class _AddDoctorFormState extends State<AddDoctorForm> {
  bool sunday = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;

  TextEditingController myDoctorNameController = TextEditingController();
  TextEditingController myDoctorEmailController = TextEditingController();
  TextEditingController myDoctorPasswordController = TextEditingController();
  TextEditingController myDoctorPhoneController = TextEditingController();
  TextEditingController myDoctorSpecializationController =
      TextEditingController();
  TextEditingController myDoctorExperienceController = TextEditingController();
  TextEditingController myDoctorAboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: Center(
            child: Text(
              'Add Doctor',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        CustomTextField(
          hintText: 'Doctor Name',
          icon: Icons.person,
          myController: myDoctorNameController,
        ),
        CustomTextField(
          hintText: 'Doctor Email',
          icon: Icons.email,
          myController: myDoctorEmailController,
        ),
        CustomTextField(
          hintText: 'Doctor Password',
          icon: Icons.password,
          myController: myDoctorPasswordController,
        ),
        CustomTextField(
          hintText: 'Phone Number',
          icon: Icons.phone,
          myController: myDoctorPhoneController,
        ),
        CustomTextField(
          hintText: 'Specialization',
          icon: Icons.school,
          myController: myDoctorSpecializationController,
        ),
        CustomTextField(
          hintText: 'Experience',
          icon: Icons.star_border,
          myController: myDoctorExperienceController,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 150),
          child: RadioButton(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Center(
              child: Text('Work Days:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        ),
        ...[
          "Sunday",
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday"
        ].asMap().entries.map((entry) {
          int idx = entry.key;
          String day = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: Container(
              color: Colors.white,
              child: CheckboxListTile(
                title: Text(
                  day,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                value: getDayValue(idx),
                onChanged: (bool? value) {
                  setDayValue(idx, value);
                },
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: TextAbout(
            myController: myDoctorAboutController,
          ),
        ),
        BlocProvider(
          create: (context) => AddDoctorCubit(),
          child: Container(
              margin: const EdgeInsets.only(left: 300, right: 300, top: 30),
              child: Builder(builder: (context) {
                return StanderButton(
                  text: 'Submit',
                  onPressed: () {
                    if (validateForm()) {
                      submitForm(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Doctor Added Successfully',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      myDoctorNameController.clear();
                      myDoctorEmailController.clear();
                      myDoctorPasswordController.clear();
                      myDoctorPhoneController.clear();
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
        ),
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
        myDoctorEmailController.text.isEmpty ||
        myDoctorPasswordController.text.isEmpty ||
        myDoctorPhoneController.text.isEmpty ||
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

  void submitForm(BuildContext context) {
    List<bool> workDays = [
      sunday,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday
    ];
    context.read<AddDoctorCubit>().createDoctor(
          doctorname: myDoctorNameController.text,
          doctoremail: myDoctorEmailController.text,
          password: myDoctorPasswordController.text,
          specialization: myDoctorSpecializationController.text,
          about: myDoctorAboutController.text,
          phone: myDoctorPhoneController.text,
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
