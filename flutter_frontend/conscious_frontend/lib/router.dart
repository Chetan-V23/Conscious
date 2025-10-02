import 'dart:async';

import 'package:flutter/material.dart';
import 'package:conscious_frontend/views/login_ui.dart';
import 'package:conscious_frontend/views/splash_screen.dart';
import 'package:conscious_frontend/views/welcome_screen.dart';
import 'auth/auth_bloc/authentication_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:conscious_frontend/views/task_view.dart';

final AuthenticationBloc authBloc = AuthenticationBloc();

class AppRouter {
  AuthenticationBloc authBloc;
  late GoRouter router;
  AppRouter(this.authBloc) {
    router = GoRouter(
      initialLocation: SplashScreen.routeName,
      routes: [
        GoRoute(
          name: SplashScreen.routeAlias,
          path: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: WelcomeScreen.routeName,
          name: WelcomeScreen.routeAlias,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: LoginUI.routeName,
          name: LoginUI.routeAlias,
          builder: (context, state) => const LoginUI(),
        ),
        // GoRoute(
        //   path: TaskChecklistPage.routeName,
        //   name: TaskChecklistPage.routeAlias,
        //   builder: (context, state) => TaskChecklistPage(),
        // ),
      ],
      refreshListenable: StreamToListenable([authBloc.stream]),
      redirect: (context, state) {
        final isAuthenticated = authBloc.state is Authenticated;
        final isUnauthenticated = authBloc.state is Unauthenticated;
        if (isAuthenticated && (state.matchedLocation == LoginUI.routeName || state.matchedLocation == SplashScreen.routeName)) {
          return WelcomeScreen.routeName;
        }
        else if(isUnauthenticated && state.matchedLocation != LoginUI.routeName){
          return LoginUI.routeName;
        }
        else{
          return null;
        }
      }
    );
  }
}

class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var stream in streams) {
      var s = stream.asBroadcastStream().listen((_) => notifyListeners());
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var s in subscriptions) {
      s.cancel();
    }
    super.dispose();
  }
}
