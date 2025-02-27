import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/Strings.dart';
import '../helpers/my_colors.dart';

class MyDrawer extends StatefulWidget{
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final String firstName = globalFirstName ?? "User";

  XFile? _cameraImage;

  XFile? _galleryImage;

  File? _lastSelectedImage;

  void pickCameraImage() async {
    final ImagePicker picker = ImagePicker();
    var cameraImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (cameraImage != null) {
        _cameraImage = cameraImage;
        _lastSelectedImage = File(_cameraImage!.path);
        //uploadImage(_lastSelectedImage!);
        uploadImageToStorage();

      }
    });
  }

  void pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    var galleryImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (galleryImage != null) {
        _galleryImage = galleryImage;
        _lastSelectedImage = File(_galleryImage!.path);
        //uploadImage(_lastSelectedImage!);
        uploadImageToStorage();
      }
    });
  }

  Future<String?> uploadImageToStorage() async {
    try {
      if (_lastSelectedImage == null) {
        debugPrint("No image selected.");
        return null;
      }

      final Reference imageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');

      debugPrint("Uploading file: ${_lastSelectedImage!.path}");

      final UploadTask uploadTask = imageRef.putFile(_lastSelectedImage!);
      final TaskSnapshot snapshot = await uploadTask;

      final String downloadURL = await snapshot.ref.getDownloadURL();
      debugPrint("File uploaded. Download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading image: $e")),
      );
      return null;
    }
  }

  Widget showModalButtonSheet() {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: MyColors.LightBlack,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              'Choose an option',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.WiledGreen,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: pickGalleryImage,
                  icon: Icon(Icons.photo_library, color: MyColors.WiledGreen),
                  style: ElevatedButton.styleFrom(backgroundColor: MyColors.LightBlack,
                    side: BorderSide(
                      color:  Colors.black, // Border color
                      width: 1, // Border width
                    ),

                  ),
                  label: Text(
                    'Gallery',
                    style: TextStyle(color: MyColors.Grey),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: pickCameraImage,
                  icon: Icon(Icons.camera_alt, color: MyColors.WiledGreen),
                  style: ElevatedButton.styleFrom(backgroundColor: MyColors.LightBlack,
                    side: BorderSide(
                      color:  Colors.black, // Border color
                      width: 1, // Border width
                    ),

                  ),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: MyColors.Grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context){
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 250,
          child: DrawerHeader(

            decoration: BoxDecoration(
              color: MyColors.LightBlack,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColors.Grey,
                      radius: 50,
                      backgroundImage: _lastSelectedImage !=null ?FileImage(_lastSelectedImage!)  // Image selected from gallery
                          : AssetImage('assets/images/freepik-untitled-project-202502222126512ePt.png') // Default image
                      as ImageProvider,
                    ),

                    Column(
                      children: [
                        SizedBox(
                          height: 65,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 55,
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      showModalButtonSheet(),
                                );
                              },
                              icon: Icon(Icons.camera_alt,
                                  color:MyColors.Grey),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '$firstName',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Welcome back!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ),


        ListTile(
          leading: Icon(Icons.notification_add, color: MyColors.WiledGreen),
          title: Text('Notification', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pushNamed(context, notification);
            // Navigate to Home
          },
        ),
        /*ListTile(
          leading: Icon(Icons.monitor_heart, color: MyColors.WiledGreen),
          title: Text('Heart Rate', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveHeartRate()));
            // Navigate to Home
          },
        ),*/
        ListTile(
          leading: Icon(Icons.self_improvement, color: MyColors.WiledGreen),
          title: Text('Tips', style: TextStyle(color: Colors.white)),
          onTap: () {
Navigator.pushNamed(context, tips);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: MyColors.WiledGreen),
          title: Text('Settings', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pushNamed(context, setting);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, color: MyColors.WiledGreen),
          title: Text('Log Out', style: TextStyle(color: Colors.white)),
          onTap: () {
            // Handle logout action
          },
        ),
      ],
    );

  }
}