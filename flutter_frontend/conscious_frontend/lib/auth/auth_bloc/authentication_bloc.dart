import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_helper_methods.dart';
import 'package:conscious_frontend/models/user.dart';
import '../user_helper_methods.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  AuthenticationBloc() : super( Uninitialized()){

    on<LoggedIn>((event, emit) async{

      emit(Authenticated(user: event.user));
    });

    on<LogOut>((event, emit) async{
      emit(AuthenticationLoadInProgress());
      await AuthHelperMethods().deleteAuthToken();
      await UserHelperMethods().deleteUserDataFromStorage();
      emit(Unauthenticated());
    });


    on<AuthenticationStatusChecked>((event, emit)async {
      String? user_token = await AuthHelperMethods().getAuthToken();
      print(user_token);
      if (user_token == null){
        print("Emitting unauthenticated");
        emit(Unauthenticated());
        return;
      }
      // Check if the token is valid and get user data
      final User? user = await UserHelperMethods().getUserDataFromAuthToken(user_token);
      emit(Authenticated(user: user));
    });
  }

}