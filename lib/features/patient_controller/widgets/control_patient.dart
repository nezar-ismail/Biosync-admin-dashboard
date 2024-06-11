import 'package:admin/core/models/constant.dart';
import 'package:admin/core/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/features/home/cubit/admin_cubit.dart';

class ControlPatient extends StatelessWidget {
  const ControlPatient({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<AdminCubit>()
        .getAllPatientInfo(); // Fetch patient when the widget is built

    return BlocBuilder<AdminCubit, AdminCubitState>(
      builder: (context, state) {
        if (state is PatientCubitLoaded) {
          return Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 100, top: 50),
                child: Text(
                  "PATIENT'S CONTROLLER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.patientInfo.length,
                  itemBuilder: (context, index) {
                    return PatientCard(patient: state.patientInfo[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state is PatientCubitError) {
          return const Center(child: Text("Failed to load USERS<Patient>"));
        } else {
          return const Center(child: Text("Patient"));
        }
      },
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage: NetworkImage(Constants.ipAddress + patient.image),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(patient.username),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 15),
          child:
              Text('Email: ${patient.useremail},      Phone: ${patient.phone}'),
        ),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 5,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeletePatientDialog(context, patient),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeletePatientDialog(BuildContext context, PatientModel patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AdminCubit, AdminCubitState>(
          listener: (context, state) {
            if (state is PatientCubitLoaded) {
              Navigator.of(context).pop(); // Dismiss the dialog automatically
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${patient.username} successfully deleted."),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PatientCubitError) {
              Navigator.of(context).pop(); // Optionally pop the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Failed to delete user<patient>. ${patient.username}."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: AlertDialog(
            title: const Text("Confirm Delete"),
            content: Text(
                "Are you sure you want to delete Dr. ${patient.username}?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  context.read<AdminCubit>().deletePatient(patient.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
