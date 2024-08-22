import 'package:e_commerse_app/constant.dart';
import 'package:e_commerse_app/layout/layoutScreen/layout.dart';
import 'package:e_commerse_app/layout/profil_cubit/profil_cubit.dart';
import 'package:e_commerse_app/modules/screens/authentication_screen/login.dart';
import 'package:e_commerse_app/modules/sheard/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.intialise();
  token = CashNetwork.get(key: 'token');
  myPassword = CashNetwork.get(key: 'pass');
  debugPrint('token is $token');
  debugPrint('current password is $myPassword');
  runApp(const CommerseApp());
}

class CommerseApp extends StatelessWidget {
  const CommerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getCart()
              ..getBanner()
              ..getProduct()
              ..getFavorite()
              ..getProfile()
              ..getCategory()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: token != null && token != "" ? const LayoutScreen() : Login(),
      ),
    );
  }
}
// qLf1HMBSHDVhUjj6onJM1E03LFPGFX8dUD5CuPKigVVgwZTMHAEZmd0kg1zhNticpWCwmv
