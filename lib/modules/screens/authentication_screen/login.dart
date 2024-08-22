import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/layoutScreen/layout.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/auth_cubit/auth_state.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final emailcontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final formkey = GlobalKey<FormState>();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Form(
        key: formkey,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/images/auth_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 40),
                    child: const Text(
                      "Login to continue process",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: const BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          // Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LayoutScreen(),
                            ),
                          );
                        } else if (state is LoginFailur) {
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
                        return ListView(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                textAlign: TextAlign.center,
                                'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _textfild(hint: 'email', control: emailcontrol),
                            const SizedBox(
                              height: 20,
                            ),
                            _textfild(hint: 'password', control: passcontrol),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailcontrol.text,
                                      pass: passcontrol.text);
                                }
                              },
                              minWidth: double.infinity,
                              color: mainColor,
                              child: state is LoginLoding
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('do not have an acounnt?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  },
                                  child: const Text(
                                    'click here',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfild(
      {required String hint, required TextEditingController control}) {
    return TextFormField(
      controller: control,
      validator: (data) {
        if (control.text.isEmpty) {
          return '$hint must not be empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
