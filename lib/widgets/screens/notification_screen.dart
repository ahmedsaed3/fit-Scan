import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helpers/my_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final List<Map<String, String>> notifications = [];
  bool isWaitingForNotification = true;

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          notifications.add({
            'title': message.notification!.title ?? 'No Title',
            'body': message.notification!.body ?? 'No Body',
            'time': DateTime.now().toString(),
          });
          isWaitingForNotification = false;
        });
      }
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      _showSettingsDialog(); // Show dialog even if permissions are granted
    } else if (status.isDenied || status.isPermanentlyDenied) {
      final result = await Permission.notification.request();
      if (result.isGranted) {
        setState(() {
          // Handle logic after enabling notifications
        });
      } else {
        _showSettingsDialog(); // Show dialog if permissions are denied
      }
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColors.LightBlack,
        title: const Text(
          "Notification Permission",
          style: TextStyle(color: MyColors.WiledGreen,fontSize: 20),
        ),
        content: const Text(
          "Notifications are disabled. Please enable them in the settings to receive updates.",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(color: MyColors.WiledGreen)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text("Settings", style: TextStyle(color: MyColors.WiledGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.LightBlack,
      appBar: AppBar(
        backgroundColor: MyColors.LightBlack,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.015,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Stay Updated!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enable notifications to never miss out on the latest updates and reminders.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _requestNotificationPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.WiledGreen,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "Manage Notifications",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            notifications.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.LightBlack,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: MyColors.WiledGreen,
                        child: const Icon(Icons.notifications, color: Colors.black),
                      ),
                      title: Text(
                        notifications[index]['title'] ?? 'No Title',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        notifications[index]['body'] ?? 'No Body',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        notifications[index]['time'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            )
                : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const Text(
                "No notifications yet.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
