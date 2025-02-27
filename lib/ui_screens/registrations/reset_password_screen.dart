import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../../widgets/helpers/my_colors.dart'; // Adjust the path if necessary

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailValue;
  String? oldPasswordValue;
  String? newPasswordValue;
  String? confirmPasswordValue;

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

  Future<void> _resetPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (newPasswordValue != confirmPasswordValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    } else {
      _formKey.currentState!.save();
      showProgressIndicator(context);

      try {
        // Fetch the user from Firestore collection using email
        final userDoc = await FirebaseFirestore.instance
            .collection('GymUsers') // Your Firestore collection
            .where('email', isEqualTo: emailValue)
            .get();

        if (userDoc.docs.isNotEmpty) {
          final userData = userDoc.docs.first.data();
          final storedPassword = userData['password'];

          // Check if the old password matches the stored password
          if (oldPasswordValue == storedPassword) {
            final userId = userDoc.docs.first.id; // Get user document ID
            await FirebaseFirestore.instance
                .collection('GymUsers')
                .doc(userId)
                .update({
              'password': newPasswordValue, // Update the password field
            });

            Navigator.pop(context); // Close the progress indicator
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password successfully updated!'),
              ),
            );
            Navigator.pop(context); // Return to the previous screen or login
          } else {
            Navigator.pop(context); // Close the progress indicator
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Old password is incorrect!'),
              ),
            );
          }
        } else {
          Navigator.pop(context); // Close the progress indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user found with this email in our system.'),
            ),
          );
        }
      } on SocketException {
        Navigator.pop(context); // Close the progress indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Network error. Please check your connection and try again.'),
          ),
        );
      } catch (e) {
        Navigator.pop(context); // Close the progress indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email!';
                        } else if (value.length < 8 ) {
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
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.Grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Old password field
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password!';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        oldPasswordValue = v;
                      },
                      cursorColor: MyColors.Grey,
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: MyColors.Grey),
                        labelText: 'Old Password',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.Grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // New password field
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new password!';
                        } else if (value.length < 8 ) {
                          return 'Password must be at least 8 characters long!';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        newPasswordValue = v;
                      },
                      cursorColor: MyColors.Grey,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: MyColors.Grey),
                        labelText: 'New Password',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.Grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Confirm password field
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      style: TextStyle(color: MyColors.Grey),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password!';
                        }
                        else if (value != passwordController.text) {
                          return 'Passwords do not match!';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        confirmPasswordValue = v;
                      },
                      cursorColor: MyColors.Grey,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: MyColors.Grey),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: MyColors.Grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.Grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.Grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _resetPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.WiledGreen,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Reset Password', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
