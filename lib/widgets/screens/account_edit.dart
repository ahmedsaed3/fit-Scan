import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';
import 'package:train_me/widgets/screens/edit_place.dart';
import '../../ui_screens/customizations/determine_goals.dart';
import '../helpers/Strings.dart';
import 'edit_email.dart';

class AccountEditing extends StatefulWidget {
  @override
  State<AccountEditing> createState() => _AccountEditingState();
}

class _AccountEditingState extends State<AccountEditing> {
  //final String firstName = globalUserName ?? "User";

  // String genderName = globalGender?? "";

  //int ageNumber = globalAgeNumber?? 0 ;
  void _showAgeSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyColors.LightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int tempAge = globalAgeNumber!; // Temporary age to store selection

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Select Age",
                      style:
                          TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: tempAge - 15),
                      onSelectedItemChanged: (int index) {
                        setSheetState(() {
                          tempAge = index + 15;
                        });
                      },
                      children: List<Widget>.generate(86, (index) {
                        int ageValue = 15 + index;
                        return Center(
                          child: Text(
                            "$ageValue",
                            style: TextStyle(
                              fontSize: ageValue == tempAge ? 22 : 18,
                              color: ageValue == tempAge
                                  ? MyColors.WiledGreen
                                  : Colors.grey,
                              fontWeight: ageValue == tempAge
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // ageNumber = tempAge;
                        globalAgeNumber = tempAge; // Update global variable
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.WiledGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showGenderSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyColors.LightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select Gender",
                  style: TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
              ListTile(
                title: Text("Male", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() => globalGender = "Male");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Female", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() => globalGender = "Female");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
                  height: 100,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditEmail()));
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Email',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        '$globalUserName',
                        style: TextStyle(color: MyColors.Grey),
                      ),
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
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Password',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        '*************',
                        style: TextStyle(color: MyColors.Grey),
                      ),
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
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Gender',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        "$globalGender",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: _showGenderSelectionSheet,
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
                      onTap: _showAgeSelectionSheet,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Age',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        "$globalAgeNumber",
                        style: TextStyle(color: MyColors.Grey),
                      ),
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
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Goal',
                        style: TextStyle(color: MyColors.WiledGreen),

                      ),
                      subtitle: Text(
                        "$globalGoalSelected",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomizeGoals()));
                      },
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
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Place',
                        style: TextStyle(color: MyColors.WiledGreen),

                      ),
                      subtitle: Text(
                        "$globalPlaceSelected",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPlace()));
                      },
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

