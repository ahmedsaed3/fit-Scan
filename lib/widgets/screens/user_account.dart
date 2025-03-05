import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/Strings.dart';
import '../helpers/my_colors.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final String firstName = globalUserName ?? "User";

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

      final UploadTask uploadTask = imageRef.putFile(_lastSelectedImage!);
      final TaskSnapshot snapshot = await uploadTask;

      final String downloadURL = await snapshot.ref.getDownloadURL();
      debugPrint("File uploaded. Download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      debugPrint("Error uploading image: $e");
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
                fontFamily: 'Abel',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.LightBlack,
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  label:
                      Text('Gallery', style: TextStyle(color: MyColors.Grey)),
                ),
                ElevatedButton.icon(
                  onPressed: pickCameraImage,
                  icon: Icon(Icons.camera_alt, color: MyColors.WiledGreen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.LightBlack,
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  label: Text('Camera', style: TextStyle(color: MyColors.Grey)),
                ),
              ],
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
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MyColors.WiledGreen, // Your custom green color
                        width: 1, // Adjust border width as needed
                      )),
                    child: CircleAvatar(
                      backgroundColor: MyColors.Grey,
                      radius: 50,
                      backgroundImage: _lastSelectedImage != null
                          ? FileImage(_lastSelectedImage!)
                          : const AssetImage(
                                  'assets/images/freepik-untitled-project-20250222212326pQr7.png')
                              as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => showModalButtonSheet(),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.WiledGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.camera_alt,
                          color: MyColors.LightBlack,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '$firstName',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [MyColors.WiledGreen, MyColors.WiledGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.black, size: 40),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Connect Premium',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'And get unlimited training',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, accountEdit);
                    },
                    leading: Icon(Icons.edit, color: Colors.white),
                    title: Text('Edit Profile',
                        style: TextStyle(color: Colors.white)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, notification);
                    },
                    leading: Icon(Icons.notifications, color: Colors.white),
                    title: Text('Notifications',
                        style: TextStyle(color: Colors.white)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.payment, color: Colors.white),
                    title: Text('Payment/Cards',
                        style: TextStyle(color: Colors.white)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
