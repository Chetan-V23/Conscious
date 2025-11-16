import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/auth_bloc/authentication_bloc.dart';
import 'router.dart';
void main() {
  final AuthenticationBloc authBloc = AuthenticationBloc();
  final appRouter = AppRouter(authBloc);
  runApp(MyApp(appRouter: appRouter,authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthenticationBloc authBloc;
  final AppRouter appRouter;
  const MyApp({required this.authBloc, required this.appRouter, super.key});

  @override
  Widget build(BuildContext context) {

    final router = appRouter.router;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authBloc,),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
