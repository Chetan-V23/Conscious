import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conscious_frontend/auth/auth_bloc/authentication_bloc.dart';
import 'package:conscious_frontend/auth/google_sign_in.dart';
import 'package:conscious_frontend/models/user.dart';

class LoginUI extends StatelessWidget {
  static const String routeName = '/login';
  static const String routeAlias = 'login';
  
  const LoginUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                User? user = await SignInWithGoogle().buttonSignIn();
                if(user!= null){
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn(user: user));
                }
              },
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginUI(),
  ));
}