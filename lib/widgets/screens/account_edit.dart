import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import 'package:train_me/widgets/screens/change_age.dart';

import '../../ui_screens/customizations/determine_age.dart';
import '../helpers/Strings.dart';

class AccountEditing extends StatefulWidget {
  @override
  State<AccountEditing> createState() => _AccountEditingState();
}

class _AccountEditingState extends State<AccountEditing> {
  final String firstName = globalFirstName ?? "User";

  final String genderName = globalGender?? "";

  final int ageNumber = globalAge?? 0 ;

  final int ageNumber2 = globalAge2?? 0 ;
  void initState() {
    super.initState();
    updateGlobalAge(); // Ensure global age is updated when the screen loads
  }

  void updateGlobalAge() {
    setState(() {
      // Print the old value of globalAge before updating
      final oldGlobalAge = globalAge;
      print('Old Global Age: $oldGlobalAge');  // Print the previous value of globalAge

      // Update globalAge only if globalAge2 has a valid value and is different
      if (globalAge2 != null && globalAge2 != globalAge) {
        globalAge = globalAge2;  // Update globalAge
      }

      print('Updated Global Age: $globalAge');  // Print the updated value of globalAge
    });
  }




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Account Information",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.LightBlack,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 110,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailChanging()));},
                      trailing: Icon(Icons.arrow_forward_ios,color: MyColors.Grey,),
                      title: Text('Email',style: TextStyle(color: MyColors.WiledGreen),),
                      subtitle: Text('$firstName\n\n$genderName',style: TextStyle(color: MyColors.Grey),),

                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios,color: MyColors.Grey,),

                      title: Text('Password',style: TextStyle(color: MyColors.WiledGreen),),
                      subtitle: Text('*************',style: TextStyle(color: MyColors.Grey),),


                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
               /* SizedBox(
                  height: 100,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios,color: MyColors.Grey,),

                      title: Text('Gender',style: TextStyle(color: MyColors.WiledGreen),),
                      subtitle: Text(genderName,style: TextStyle(color: MyColors.Grey),),

                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 100,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeAge()));},
                      trailing: Icon(Icons.arrow_forward_ios,color: MyColors.Grey,),

                      title: Text('Age',style: TextStyle(color: MyColors.WiledGreen),),
                      subtitle: Text("$globalAge",style: TextStyle(color: MyColors.Grey),),

                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios,color: MyColors.Grey,),

                      title: Text('Goal',style: TextStyle(color: MyColors.WiledGreen),),

                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
          Text('Change email address',style: TextStyle(color: MyColors.Grey,fontSize: 20),),
          SizedBox(height: 100,),
          Container(
            margin: EdgeInsets.only(left: 10),
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
          SizedBox(height: 100,),
          Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)
            ),
            child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: MyColors.LightBlack ) ,
                onPressed: (){}, child: Text('Continue',style: TextStyle(color: MyColors.WiledGreen),)),
          )
        ],
      ),

    );
  }





}

