import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/login_cubit/google_login_cubit.dart';
import 'Strings.dart';
import 'my_colors.dart';

class LoginAndSignUp extends StatefulWidget {
  @override
  State<LoginAndSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginAndSignUp> {
  bool? login = true;
  bool? signup = false;

  void clickLogin() {
    setState(() {
      login = true;
      signup = false;
    });
  }

  void clickSignup() {
    setState(() {
      login = false;
      signup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 130),
      width: 295,
      height: 50,
      decoration: BoxDecoration(
        color: MyColors.LightBlack,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: MyColors.LightBlack,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              clickLogin();
              Navigator.pushNamed(context, loginCase);
            },
            child: Container(
              width: 135,
              height: 50,
              decoration: BoxDecoration(
                color: login == true ? Colors.black : MyColors.LightBlack,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: login == true ? MyColors.WiledGreen : MyColors.Grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              clickSignup();
              Navigator.pushNamed(context, signUp);
            },
            child: Container(
              width: 135,
              height: 50,
              decoration: BoxDecoration(
                color: signup == true ? Colors.black : MyColors.LightBlack,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: signup == true ? MyColors.WiledGreen : MyColors.Grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleAndFacebook extends StatefulWidget {
  @override
  State<GoogleAndFacebook> createState() => _GoogleAndFacebookState();
}

class _GoogleAndFacebookState extends State<GoogleAndFacebook> {
  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(MyColors.WiledGreen),
        ),
      ),
    );

    showDialog(
      // barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  /*Future<void> saveFirstName(String firstName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName ', firstName);

  }*/
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  String getFirstName(String email) {
    // Split the email at '@' to get the username part
    String username = email.split('@').first;

    // Use a regular expression to match lowercase letters from the start of the username
    RegExp regex = RegExp(r'^[a-z]+');
    Match? match = regex.firstMatch(username);

    // If a match is found, return the first name part
    if (match != null) {
      return match.group(0)!; // group(0) will return the matched substring
    }

    // If no match found, return an empty string
    return '';
  }

  /*Future<void> facebookRegister() async {
    if (!await _hasInternetConnection()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection. Please try again later.'),
        ),
      );
      return;
    } else {
      BlocProvider.of<FacebookLoginCubit>(context).signInWithFacebook();
    }
  }*/

  Future<void> googleRegister() async {
    if (!await _hasInternetConnection()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection. Please try again later.'),
        ),
      );
      return;
    } else {
      BlocProvider.of<GoogleLoginCubit>(context).signInWithGoogle();
    }
  }

  /* Widget buildFacebookBloc() {
    return BlocListener<FacebookLoginCubit, FacebookLoginState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is FacebookLoginLoading) {
          showProgressIndicator(context);
        }
        if (state is FacebookLoginSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, gender);
        }
        if (state is FacebookLoginFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed'),
            ),
          );
        }
      },
      child: Container(),
    );
  }
*/
  Widget buildGoogleBloc() {
    return BlocListener<GoogleLoginCubit, GoogleLoginState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) async {
        if (state is GoogleLoginLoading) {
          showProgressIndicator(context);
        }
        if (state is GoogleLoginSuccess) {
          Navigator.pop(context);
          String userName = getFirstName(state.email);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('firstName', userName);
          Navigator.pushReplacementNamed(context, gender);
        }
        if (state is GoogleLoginFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed'),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                color: MyColors.LightBlack,
                width: 70,
                height: 70,
                child: Image.asset(
                    fit: BoxFit.cover,
                    'assets/images/google-symbol-logo-design-illustration-with-black-background-free-vector.jpg'),
              ),
              onTap: () {
                googleRegister();
              },
            ),
            /*SizedBox(
              width: 50,
            ),*/
            /*InkWell(
              onTap: () {
                facebookRegister();
              },
              child: Container(
                color: MyColors.LightBlack,
                width: 70,
                height: 70,
                child: Image.asset(
                    fit: BoxFit.cover, 'images/facebookdarkmode_logo.jpg'),
              ),
            ),*/
          ],
        ),
        //buildFacebookBloc(),
        buildGoogleBloc()
      ],
    );
  }
}
