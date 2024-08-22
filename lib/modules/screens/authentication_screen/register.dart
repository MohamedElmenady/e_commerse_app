import 'package:e_commerse_app/modules/screens/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/auth_cubit/auth_state.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/login.dart';
import 'package:e_commerse_app/modules/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  final namecontrol = TextEditingController();
  final emailcontrol = TextEditingController();
  final phonecontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  bool isloding = false;
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is AuthFailur) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: fromkey,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'sign Up',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfield(hint: 'username', controller: namecontrol),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfield(hint: 'email', controller: emailcontrol),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfield(hint: 'phone', controller: phonecontrol),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfield(
                        hint: 'passWord',
                        controller: passcontrol,
                        isSecur: true),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (fromkey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).register(
                                    name: namecontrol.text,
                                    email: emailcontrol.text,
                                    phone: phonecontrol.text,
                                    pass: passcontrol.text);
                              }
                            },
                            child: state is AuthLoding
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Register',
                                  )),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        'already have an acounnt',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text(
                          'login',
                          style: TextStyle(color: Colors.purple),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _textfield(
      {bool? isSecur,
      required String hint,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (controller.text.isEmpty) {
          return '$hint must not be empty';
        } else {
          return null;
        }
      },
      obscureText: isSecur ?? false,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
