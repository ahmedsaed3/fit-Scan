import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/Strings.dart';
import '../helpers/my_colors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = "English";

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColors.LightBlack,
        title: Text(
          "select_language".tr(),
          style: TextStyle(color: MyColors.WiledGreen),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text("English", style: TextStyle(color: Colors.white)),
              activeColor: MyColors.WiledGreen,
              value: "English",
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                  context.setLocale(Locale('en')); // Change language to English
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: Text("Arabic", style: TextStyle(color: Colors.white)),
              activeColor: MyColors.WiledGreen,
              value: "Arabic",
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                  context.setLocale(Locale('ar')); // Change language to Arabic
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: MyColors.LightBlack,
        title: Text("settings".tr(), style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: MyColors.LightBlack,
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
           /* ListTile(
              leading: Icon(Icons.language, color: MyColors.WiledGreen),
              title: Text("language".tr(), style: TextStyle(color: Colors.white)),
              subtitle: Text(
                _selectedLanguage,
                style: TextStyle(color: Colors.white70),
              ),
              onTap: _showLanguageSelectionDialog,
            ),*/
            ListTile(
              leading: Icon(Icons.person, color: MyColors.WiledGreen),
              title: Text("account", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, userAccount);
              },
            ),
            Divider(color: Colors.white54),
            ListTile(
              leading: Icon(Icons.help_outline, color: MyColors.WiledGreen),
              title: Text("help_support".tr(), style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, helpAndSupport);
              },
            ),
          ],
        ),
      ),
    );
  }
}
