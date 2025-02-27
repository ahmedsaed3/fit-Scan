/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';

part 'facebook_login_state.dart';

class FacebookLoginCubit extends Cubit<FacebookLoginState> {
  FacebookLoginCubit() : super(FacebookLoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithFacebook() async {
    try {
      // Emit loading state
      emit(FacebookLoginLoading());

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Check if the login was successful
      if (loginResult.status == LoginStatus.success) {
        // Get the access token object from the login result
        final AccessToken? accessToken = loginResult.accessToken;

        if (accessToken != null) {
          // Create a credential from the access token object
          final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken!.token);

          // Once signed in, return the UserCredential
          final UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);

          // Emit success state
          emit(FacebookLoginSuccess());
        } else {
          // Emit failure state if access token retrieval fails
          emit(FacebookLoginFailure());
          throw Exception('Failed to retrieve Facebook access token.');
        }
      } else {
        // Emit failure state if login fails
        emit(FacebookLoginFailure());
        throw Exception('Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      // Emit error state with the exception message
      emit(FacebookLoginError(e.toString()));
    }
  }
}


 */