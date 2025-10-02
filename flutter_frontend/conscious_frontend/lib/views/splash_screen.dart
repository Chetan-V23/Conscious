import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conscious_frontend/auth/auth_bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  static const String routeAlias = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _retrieve_user_token_and_navigate();
    
  }

  void _retrieve_user_token_and_navigate() async {

    BlocProvider.of<AuthenticationBloc>(context).add( AuthenticationStatusChecked());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gps_fixed,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Man in Front of the Gun',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}