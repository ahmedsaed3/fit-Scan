import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'google_login_state.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  GoogleLoginCubit() : super(GoogleLoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    emit(GoogleLoginLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(GoogleLoginFailure());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final email = googleUser.email;
      await _auth.signInWithCredential(credential);
      emit(GoogleLoginSuccess(email));
    } catch (e) {
      emit(GoogleLoginFailure());
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    emit(GoogleLoginInitial());
  }
}
