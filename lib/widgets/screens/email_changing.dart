import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class EmailChanging extends StatelessWidget{
  final emailController = TextEditingController();
  String? emailValue;
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text('Change email address',style: TextStyle(color: MyColors.Grey),),
          SizedBox(
            width: 320,
            child: TextFormField(
              style: TextStyle(color: MyColors.Grey),
              onChanged: print,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email!';
                } else if (
                value.length < 8
                ) {
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
                    color: Colors.black, // Set your border color
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Set your border color when focused
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Set your border color when disabled
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }





}