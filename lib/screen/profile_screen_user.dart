import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sawahcek/screen/login_screen.dart';
import 'package:sawahcek/screen/setting_screen_user.dart';
import 'package:sawahcek/screen/signup_screen_admin.dart';

class ProfileUser extends StatefulWidget {
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;

  ProfileUser({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Uint8List? _image;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    fetchProfilePicture(); // Automatically fetch the profile picture on page load
  }

  Widget userInfoProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color.fromRGBO(0, 63, 100, 50),
          width: 3.0,
        ),
        color: Colors.white60,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 16,),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('My Setting'),
            const Spacer(),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Add your logic based on the selected value
                if (value == 'option1') {
                  // Handle option 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupAdmin(), // Navigate to SignupAdmin
                    ),
                  );
                }

                if (value == 'option2') {
                  // Handle option 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsUser( id: widget.id.toString(),
                        fullname: widget.fullname,
                        username: widget.username,
                        email: widget.email,
                        password: widget.password,), // Navigate to SignupAdmin
                    ),
                  );
                }
                // Add more options as needed
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'option1',
                  child: Text('Register New Admin'),
                ),
                // Add more options as needed

                const PopupMenuItem<String>(
                  value: 'option2',
                  child: Text('Change My Profile Settings '),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to DashboardAdmin
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  GestureDetector(
                    onTap: () {
                      _showImageFullScreen();
                    },
                    child: Hero(
                      tag: "profile_image",
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                              radius: 100, backgroundImage: MemoryImage(_image!))
                              : const CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                          ),
                          Positioned(
                            bottom: -0,
                            left: 140,
                            child: IconButton(
                              onPressed: () {
                                showImagePickerOption(context);
                              },
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            userInfoProfile(Icons.person, widget.username),
            const SizedBox(height: 20,),
            userInfoProfile(Icons.email, widget.email),
            const SizedBox(height: 20,),
            Center(
              child: Material(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(32),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageFullScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Hero(
              tag: "profile_image",
              child: _image != null
                  ? Image.memory(_image!)
                  : const Image(
                image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    uploadSelectedImageToServer(widget.email);
    Navigator.of(context).pop(); // Close the modal sheet
  }

  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    uploadSelectedImageToServer(widget.email);
    Navigator.of(context).pop();
  }

  void uploadSelectedImageToServer(String userEmail) async {
    if (selectedImage != null) {
      String uploadUrl = "http://10.131.73.13/sawahcek/upload.php"; // Replace with your actual server URL

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage!.path));
      request.fields['email'] = userEmail; // Pass the user's email

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          print("Image uploaded successfully");
        } else {
          print("Failed to upload image. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("No image selected to upload.");
    }
  }

  Future<void> fetchProfilePicture() async {
    String apiUrl = "http://10.131.73.13/sawahcek/upload.php"; // Replace with your actual server URL
    String userEmail = widget.email; // Use the email from the widget

    try {
      var response = await http.get(Uri.parse('$apiUrl?email=$userEmail'));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          setState(() {
            _image = response.bodyBytes;
          });
        } else {
          // No picture found, set _image to null
          setState(() {
            _image = null;
          });
        }
      } else {
        print("Failed to fetch profile picture. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile picture: $e");
    }
  }
}
