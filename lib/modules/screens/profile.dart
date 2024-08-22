import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_state.dart';
import 'package:e_commerse_app/modules/screens/changePass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is FailureState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<LayoutCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: cubit.userModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(cubit.userModel!.image!)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          cubit.userModel!.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          cubit.userModel!.email!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChangePassword();
                            }));
                          },
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: mainColor,
                          minWidth: double.infinity,
                        )
                      ]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
