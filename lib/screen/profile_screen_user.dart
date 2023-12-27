import 'package:flutter/material.dart';
import 'package:sawahcek/screen/login_screen.dart';
import 'package:sawahcek/screen/setting_screen_user.dart';
import 'package:sawahcek/screen/signup_screen_admin.dart';

class ProfileUser extends StatelessWidget {
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
                      builder: (context) => SettingsUser( id: id.toString(),
                        fullname: fullname,
                        username: username,
                        email: email,
                        password: password,), // Navigate to SignupAdmin
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
              child: Image.asset(
                "images/kebun.png",
                width: 240,
              ),
            ),
            const SizedBox(height: 20,),
            userInfoProfile(Icons.person, username),
            const SizedBox(height: 20,),
            userInfoProfile(Icons.email, email),
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
}
