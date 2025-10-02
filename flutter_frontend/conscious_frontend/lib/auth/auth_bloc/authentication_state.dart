part of 'authentication_bloc.dart';

sealed class AuthenticationState {
  User? user;
  AuthenticationState({this.user});
}
class Uninitialized extends AuthenticationState {
  Uninitialized(): super(user: null);
}
class Unauthenticated extends AuthenticationState {
  Unauthenticated(): super(user: null);
}

class Authenticated extends AuthenticationState {
  User? user;
  Authenticated({this.user}): super(user: user);
}

class AuthenticationLoadInProgress extends AuthenticationState {
  AuthenticationLoadInProgress(): super(user: null);
}