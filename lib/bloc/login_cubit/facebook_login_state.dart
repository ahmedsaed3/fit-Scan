part of 'facebook_login_cubit.dart';


abstract class FacebookLoginState {}

class FacebookLoginInitial extends FacebookLoginState {}

class FacebookLoginLoading extends FacebookLoginState {}

class FacebookLoginSuccess extends FacebookLoginState {

}

class FacebookLoginFailure extends FacebookLoginState {}

class FacebookLoginError extends FacebookLoginState {
  final String message;

  FacebookLoginError(this.message);
}
