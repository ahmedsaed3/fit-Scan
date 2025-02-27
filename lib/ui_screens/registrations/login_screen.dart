import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../widgets/helpers/Strings.dart';
import '../../widgets/helpers/login_helper.dart';
import '../../widgets/helpers/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  late String googleAccount;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailValue;
  String? passWordValue;
  bool _isPasswordVisible = false;

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
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      showProgressIndicator(context);

      if (!await _hasInternetConnection()) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No internet connection. Please try again later.'),
          ),
        );
        return;
      }
      try {
        final field = await FirebaseFirestore.instance
            .collection('GymUsers')
            .where('email', isEqualTo: emailValue)
            .get();

        if (field.docs.isNotEmpty) {
          final doc = field.docs.first;
          if (passWordValue == doc['password']) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, gender);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Something went wrong. Check your email or password.'),
              ),
            );
            Navigator.pop(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Something went wrong. Check your email or password.'),
            ),
          );
          Navigator.pop(context);
        }
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Firebase error: ${e.message}. Please try again.'),
          ),
        );
      } on SocketException {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Network error. Please check your connection and try again.'),
          ),
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred.'),
          ),
        );
      }
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: LoginAndSignUp(),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      onChanged: print,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email!';
                        } else if (value.length < 8) {
                          return 'Invalid email format!';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        emailValue = v;
                        globalFirstName = v;
                      },
                      cursorColor: MyColors.Grey,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: MyColors.Grey),
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey, // Set your border color
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors
                                .Grey, // Set your border color when focused
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors
                                .Grey, // Set your border color when disabled
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password!';
                        } else if (value.length < 8) {
                          return 'Invalid password!';
                        } else if (value.length > 15) {
                          return 'Invalid password!';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        passWordValue = v;
                      },
                      cursorColor: MyColors.Grey,
                      obscureText: !_isPasswordVisible,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: MyColors.Grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyColors.Grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible =
                                  !_isPasswordVisible; //very important................
                            });
                          },
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey, // Set your border color
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors
                                .Grey, // Set your border color when focused
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors
                                .Grey, // Set your border color when disabled
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _register(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.WiledGreen,
                      fixedSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Border radius
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Enter',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, resetPassword);
                    },
                    child: Text(
                      'Forget password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: .5, // Line thickness
                    indent: 20, // Left padding
                    endIndent: 20, // Right padding
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GoogleAndFacebook()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
