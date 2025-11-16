import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:conscious_frontend/auth/user_helper_methods.dart';
import 'package:conscious_frontend/constants/api_endpoints.dart';
import 'auth_helper_methods.dart';
import 'package:http/http.dart' as http;
import 'package:conscious_frontend/models/user.dart';
import 'dart:convert';

class SignInWithGoogle {
  final List<String> scopes = <String>[
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  SignInWithGoogle() {
    // final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    // unawaited(
    //   googleSignIn.initialize().then((_) {
    //     googleSignIn.authenticationEvents
    //         .listen(_handleAuthenticationEvent)
    //         .onError(_handleAuthenticationError);
    //     googleSignIn.attemptLightweightAuthentication();
    //   }),
    // );
  }

  Future<User?> buttonSignIn() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
    await _googleSignIn.initialize();
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.authenticate(scopeHint: scopes);
    return await signIn(googleSignInAccount);

  }

  //THIS DEBUG METHOD WILL BE REMOVED LATER
  Future<User?> dummyUser() async{
    // Simulate a delay for dummy sign-in
    await Future.delayed(Duration(milliseconds: 50));
    // Return a dummy user
    // send a call to the backend to get a dummy auth token and save it
    final response = await http.post(
      Uri.parse(DUMMY_ENDPOINT),
      headers: {CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE},
      body: jsonEncode({"id_token": "idtoken_dummy"}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String accessToken = responseData['token'];
      AuthHelperMethods().saveAuthToken(accessToken);
      User user = User.fromJson(responseData['user']);
      await UserHelperMethods().saveUserDataFromStorage(
        jsonEncode(user.toJson()),
      );
      print(user.toJson());
      return user;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
    }
    return User(name: 'Dummy User', email: '', s_acts: []);
  }

  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user =
    switch (event){
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null
    };
    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient.authorizationForScopes(scopes);
    if (user != null && authorization != null) {
      signIn(user);
    }
  }

  Future<User?> signIn(GoogleSignInAccount user) async {
    final GoogleSignInAuthentication googleAuth = user.authentication;
    final String? idToken = googleAuth.idToken;
    final response = await http.post(
      Uri.parse(GOOGLE_AUTH_ENDPOINT),
      headers: {CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE},
      body: jsonEncode({"id_token": idToken}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String accessToken = responseData['token'];
      AuthHelperMethods().saveAuthToken(accessToken);
      User user = User.fromJson(responseData['user']);
      await UserHelperMethods().saveUserDataFromStorage(
        jsonEncode(user.toJson()),
      );
      print(user.toJson());
      return user;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> _handleAuthenticationError(event){
    return Future.value(null);
  }
}

