import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:conscious_frontend/auth/auth_bloc/authentication_bloc.dart';
import 'package:conscious_frontend/views/task_view.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  static const String routeAlias = 'welcome';
  const WelcomeScreen({super.key});


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // GoRouter.of(context).go(TaskChecklistPage.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {

            return Text('Welcome, ${state.user!.name}!', style: TextStyle(fontSize: 24));
          },
        ),
      ),
    );
  }
}
