import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/Strings.dart';
import '../helpers/my_colors.dart';
import '../../bloc/login_cubit/google_login_cubit.dart';

class LogoutScreen extends StatelessWidget {

  Future<void> googleLogout(BuildContext context) async {
    BlocProvider.of<GoogleLoginCubit>(context).signOut();
  }


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
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Icon(Icons.logout, color: MyColors.WiledGreen),
      title: Text('Log Out', style: TextStyle(color: Colors.white)),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: MyColors.LightBlack,
              title: Text("Confirm", style: TextStyle(color: MyColors.WiledGreen)),
              content: Text("Are you sure?", style: TextStyle(color: MyColors.WiledGreen)),
              actions: [
                IconButton(
                    icon: Icon(Icons.check, color: MyColors.WiledGreen),
                    onPressed: () async {
                      showProgressIndicator(context);
                      await googleLogout(context);
                      Navigator.pushReplacementNamed(context, loginCase);

                    }
                ),
                IconButton(
                  icon: Icon(Icons.close, color: MyColors.WiledGreen),
                  onPressed: () {

                    Navigator.of(context).pop(); // Close the dialog

                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
