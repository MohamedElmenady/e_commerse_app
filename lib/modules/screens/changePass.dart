import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final currentPassControl = TextEditingController();
  final newPassControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(listener: (context, state) {
      if (state is ChangePassSuccess) {
        showSnackBarItem(context, "Password Updated Successfully", true);
        Navigator.pop(context);
      } else if (state is ChangePassFailurState) {
        showSnackBarItem(context, state.error, false);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          backgroundColor: thirdColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: currentPassControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'current password',
                  labelStyle: TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: newPassControl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'new password',
                  labelStyle: TextStyle(fontSize: 16)),
            ),
            const SizedBox(
              height: 12,
            ),
            MaterialButton(
              onPressed: () {
                if (myPassword == currentPassControl.text.trim()) {
                  if (newPassControl.text.length >= 6) {
                    cubit.changePass(
                        currentPassword: currentPassControl.text.trim(),
                        newPassword: newPassControl.text.trim());
                  } else {
                    showSnackBarItem(context,
                        "Password must be at least 6 characters", false);
                  }
                } else {
                  showSnackBarItem(
                      context,
                      "please, verify current password, try again later",
                      false);
                }
              },
              child: Text(
                state is ChangePassLodingState ? 'Loding...' : 'UPdate',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: mainColor,
            )
          ]),
        ),
      );
    });
  }
}

void showSnackBarItem(
    BuildContext context, String message, bool forSuccessOrFailure) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
  ));
}
