import 'package:admin/features/home/cubit/admin_cubit.dart';
import 'package:admin/features/login/view/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const AdminBioSync());
  doWhenWindowReady(() {
    appWindow.size = const Size(1200, 750);
    appWindow.minSize = const Size(1200, 750);
    appWindow.title = "Admin BioSync";
    appWindow.show();
  });
}

class AdminBioSync extends StatelessWidget {
  const AdminBioSync({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
