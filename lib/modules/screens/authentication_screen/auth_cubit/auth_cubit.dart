import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/auth_cubit/auth_state.dart';
import 'package:e_commerse_app/modules/sheard/Network.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void register(
      {required String name,
      required String email,
      required String phone,
      required String pass}) async {
    emit(AuthLoding());
    http.Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/register'),
      body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": pass,
      },
      headers: {'lang': 'en'},
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      emit(AuthSuccess());
    } else {
      emit(AuthFailur(message: responseBody['message']));
    }
  }

  void login({required String email, required String pass}) async {
    try {
      emit(LoginLoding());
      http.Response response = await http
          .post(Uri.parse('https://student.valuxapps.com/api/login'), body: {
        "email": email,
        "password": pass,
      }, headers: {
        'lang': 'en'
      });
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody['status'] == true) {
          // debugPrint('success:$responseBody');
          await CashNetwork.set(
              key: 'token', value: responseBody['data']['token']);
          CashNetwork.set(key: 'pass', value: pass);
          emit(LoginSuccess());
        } else {
          emit(LoginFailur(message: responseBody['message']));
        }
      }
    } catch (e) {
      emit(LoginFailur(message: e.toString()));
    }
  }
}
