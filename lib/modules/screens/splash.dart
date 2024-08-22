import 'package:e_commerse_app/modules/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.network(
                    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    'FASION',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            ),
          ),
          const Text(
            'Developed by mohamed reda',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
