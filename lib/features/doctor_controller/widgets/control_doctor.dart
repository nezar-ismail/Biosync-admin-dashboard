import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/core/models/doctor_model.dart';
import 'package:admin/features/home/cubit/admin_cubit.dart';

class ControlDoctor extends StatelessWidget {
  const ControlDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<AdminCubit>()
        .getAllDoctorInfo(); // Fetch doctors when the widget is built

    return BlocBuilder<AdminCubit, AdminCubitState>(
      builder: (context, state) {
        if (state is DoctorCubitLoaded) {
          return Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 100, top: 50),
                child: Text(
                  "DOCTOR'S CONTROLLER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.doctorInfo.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(doctor: state.doctorInfo[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state is DoctorCubitError) {
          return const Center(child: Text("Failed to load doctors"));
        } else {
          return const Center(child: Text("doctors"));
        }
      },
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage:
              NetworkImage("http://192.168.1.106:5000${doctor.image}"),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Dr.${doctor.doctorname}'),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(doctor.doctoremail),
        ),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 5,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove_red_eye_sharp, color: Colors.green),
              onPressed: () {
                context.read<AdminCubit>().viewDoctor(doctor: doctor);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteDialog(context, doctor),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                context.read<AdminCubit>().editDoctor(doctor: doctor);
                // Handle edit action
                // Typically would open a form to edit doctor details
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, DoctorModel doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AdminCubit, AdminCubitState>(
          listener: (context, state) {
            if (state is DoctorCubitLoaded) {
              Navigator.of(context).pop(); // Dismiss the dialog automatically
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Dr. ${doctor.doctorname} successfully deleted."),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is DoctorDeleteError) {
              Navigator.of(context).pop(); // Optionally pop the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to delete Dr. ${doctor.doctorname}."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: AlertDialog(
            title: const Text("Confirm Delete"),
            content: Text(
                "Are you sure you want to delete Dr. ${doctor.doctorname}?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  context.read<AdminCubit>().deleteDoctor(doctor.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
