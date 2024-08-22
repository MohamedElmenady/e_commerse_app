abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoding extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailur extends AuthState {
  String message;

  AuthFailur({required this.message});
}

class LoginInitial extends AuthState {}

class LoginLoding extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailur extends AuthState {
  String message;

  LoginFailur({required this.message});
}
