import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

import '../helpers/Strings.dart';
import 'edit_email.dart';

class AccountEditing extends StatefulWidget {
  @override
  State<AccountEditing> createState() => _AccountEditingState();
}

class _AccountEditingState extends State<AccountEditing> {
String gender ='gender';
String placeSelected = '';
String goalSelected='';
int ageNumber= 0;
int heightSelected =140;
int weightSelected=40;

void initState() {
  super.initState();
  StoredGenderType();
  StoredAgeNumber();
  StoredHeight();
  StoredWeight();
  StoredPlaceSelected();
  StoredGoalSelected();
}

Future<void> StoredGenderType() async {
  String  storedGender = await getGenderType();
  setState(() {
    gender= storedGender;

  });
}
Future<void> StoredPlaceSelected() async {
  String  storedPlace = await getPlaceSelected();
  setState(() {
    placeSelected= storedPlace;

  });
}
Future<void> StoredGoalSelected() async {
  String  goal = await getGoalSelected();
  setState(() {
    goalSelected = goal;

  });
}
Future<void> StoredAgeNumber() async {
  int storedAgeNumber = await getAgeNumber();
  setState(() {
    ageNumber= storedAgeNumber;

  });
}
Future<void> StoredHeight() async {
  int storedHeight = await getHeightSelected();
  setState(() {
    heightSelected= storedHeight;

  });
}
Future<void> StoredWeight() async {
  int storedWeight = await getWeightSelected();
  setState(() {
    weightSelected= storedWeight;

  });
}
Future<String> getGenderType() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('gender') ?? "gender";

}
Future<String> getPlaceSelected() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('place') ?? "";

}
Future<String> getGoalSelected() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('goal') ?? "";

}

Future<int> getAgeNumber() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('age') ?? 15;
}
Future<int> getHeightSelected() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('height') ?? 140;
}
Future<int> getWeightSelected() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('weight') ?? 40;
}
void showWeightSelectionSheet() {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.LightBlack,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      int tempWeight = weightSelected; // Temporary age to store selection

      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Weight",
                    style:
                    TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                    backgroundColor: Colors.transparent,
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                        initialItem: tempWeight - 15),
                    onSelectedItemChanged: (int index) {
                      setSheetState(() {
                        tempWeight = index + 15;
                      });
                    },
                    children: List<Widget>.generate(86, (index) {
                      int weightValue = 15 + index;
                      return Center(
                        child: Text(
                          "$weightValue kg",
                          style: TextStyle(
                            fontSize: weightValue == tempWeight ? 22 : 18,
                            color: weightValue == tempWeight
                                ? MyColors.WiledGreen
                                : Colors.grey,
                            fontWeight: weightValue == tempWeight
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
                  onPressed: ()async {
                    setState(() {
                      weightSelected = tempWeight; // Update global variable
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('weight', weightSelected);
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
void showHeightSelectionSheet() {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.LightBlack,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      int tempHeight = heightSelected; // Temporary age to store selection

      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Height",
                    style:
                    TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                    backgroundColor: Colors.transparent,
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                        initialItem: tempHeight - 15),
                    onSelectedItemChanged: (int index) {
                      setSheetState(() {
                        tempHeight = index + 15;
                      });
                    },
                    children: List<Widget>.generate(186, (index) {
                      int heightValue = 15 + index;
                      return Center(
                        child: Text(
                          "$heightValue cm",
                          style: TextStyle(
                            fontSize: heightValue == tempHeight ? 22 : 18,
                            color: heightValue == tempHeight
                                ? MyColors.WiledGreen
                                : Colors.grey,
                            fontWeight: heightValue == tempHeight
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
                  onPressed: () async{
                    setState(() {
                      heightSelected = tempHeight; // Update global variable
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('height', heightSelected);
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
              onTap: () async{
                setState((){
                  gender = "Male";
                } );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('gender', gender);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Female", style: TextStyle(color: Colors.white)),
              onTap: () async{
                setState((){
                  gender = "Female";
                } );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('gender', gender);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

  void _showAgeSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: MyColors.LightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int tempAge = ageNumber; // Temporary age to store selection

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
                    onPressed: ()async {
                      setState(() {
                        ageNumber = tempAge; // Update global variable
                      });
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('age', ageNumber);
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
  void _showGoalSelectionSheet() {
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
              Text("Select Goal",
                  style: TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
              ListTile(
                title:
                Text("Weight Loss", style: TextStyle(color: Colors.white)),
                onTap: () async{
                  setState(() {
                    goalSelected = "Weight Loss";
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('goal', goalSelected);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:
                Text("Muscle Gain", style: TextStyle(color: Colors.white)),
                onTap: () async{
                  setState(() {
                    goalSelected = "Muscle Gain";
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('goal', goalSelected);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _showPlaceSelectionSheet() {
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
              Text("Select Place",
                  style: TextStyle(color: MyColors.WiledGreen, fontSize: 18)),
              ListTile(
                title:
                Text("Gym Workout", style: TextStyle(color: Colors.white)),
                onTap: () async{
                  setState(() {
                    placeSelected = "Gym Workout";
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('place', placeSelected);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:
                Text("Home Workout", style: TextStyle(color: Colors.white)),
                onTap: ()async {
                  setState(() {
                    isHomeWorkoutSelected = true;
                    placeSelected = "Home Workout";
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('place', placeSelected);
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
                  height: 80,
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
                  height: 80,
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
                  height: 80,
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
                        "$gender",
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
                  height: 80,
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
                        "$ageNumber",
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
                  height: 80,
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
                        "$goalSelected",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: _showGoalSelectionSheet,
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
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
                        "$placeSelected",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: _showPlaceSelectionSheet,
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Weight',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        "$weightSelected kg",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: showWeightSelectionSheet,
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 180,
                  child: Card(
                    child: ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.Grey,
                      ),
                      title: Text(
                        'Height',
                        style: TextStyle(color: MyColors.WiledGreen),
                      ),
                      subtitle: Text(
                        "$heightSelected cm",
                        style: TextStyle(color: MyColors.Grey),
                      ),
                      onTap: showHeightSelectionSheet,
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
