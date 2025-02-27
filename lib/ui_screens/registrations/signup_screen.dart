import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/helpers/Strings.dart';
import '../../widgets/helpers/my_colors.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool? login = false;
  bool? signup = true;

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

  final _formKey2 = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailValue;
  String? passWordValue;
  String? confirmPassWordValue;
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

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey2.currentState!.validate()) {
      return;
    } else {
      _formKey2.currentState!.save();

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
        if (field.docs.isEmpty) {
          await FirebaseFirestore.instance.collection('GymUsers').add({
            'email': emailValue,
            'password': passWordValue,
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email added successfully.'),
            ),
          );
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User already exists with this email.'),
            ),
          );
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                          color: login == true
                              ? Colors.black
                              : MyColors.LightBlack,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: login == true
                                  ? MyColors.WiledGreen
                                  : MyColors.Grey,
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
                          color: signup == true
                              ? Colors.black
                              : MyColors.LightBlack,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: signup == true
                                  ? MyColors.WiledGreen
                                  : MyColors.Grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, right: 170),
              child: Text(
                'Enter your user name',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                key: _formKey2,
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
                        },
                        cursorColor: MyColors.Grey,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: MyColors.Grey),
                          labelText: 'User Name ',
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
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 145),
                        child: Text(
                          'Enter the password',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        style: TextStyle(color: MyColors.Grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password!';
                          } else if (value.length < 8) {
                            return 'The password must contain at least 8 characters!';
                          } else if (value.length > 15) {
                            return 'The password must not exceed 15 characters !';
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
                      height: 10,
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        style: TextStyle(color: MyColors.Grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password!';
                          } else if (value.length < 8) {
                            return 'The password must contain at least 8 characters!';
                          } else if (value.length > 15) {
                            return 'The password must not exceed 15 characters !';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          confirmPassWordValue = v;
                        },
                        cursorColor: MyColors.Grey,
                        obscureText: !_isPasswordVisible,
                        //controller: confirmPasswordController,
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
                          labelText: 'Confirm the password',
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
                          'sign up',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
