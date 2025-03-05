import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/my_colors.dart';

class EditEmail extends StatelessWidget {
  final emailController = TextEditingController();
  late final String? emailValue;

  Widget build(BuildContext context) {
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
          Text(
            'Change email address',
            style: TextStyle(color: MyColors.Grey, fontSize: 20),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
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
              autofocus: true,
              cursorColor: MyColors.Grey,
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: MyColors.WiledGreen),
                labelText: 'Email',
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
          SizedBox(
            height: 100,
          ),
          Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.LightBlack),
                onPressed: () {},
                child: Text(
                  'Continue',
                  style: TextStyle(color: MyColors.WiledGreen),
                )),
          )
        ],
      ),
    );
  }
}
