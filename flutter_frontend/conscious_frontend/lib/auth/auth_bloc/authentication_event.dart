part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}


class LoggedIn extends AuthenticationEvent {
  User user;
  LoggedIn({required this.user});
}


class LogOut extends AuthenticationEvent {

  const LogOut();
}


class AuthenticationStatusChecked extends AuthenticationEvent {

  const AuthenticationStatusChecked();
}