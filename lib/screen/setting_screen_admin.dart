import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class SettingsAdmin extends StatefulWidget {

  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;

  SettingsAdmin({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  _SettingsAdminState createState() => _SettingsAdminState();
}

class _SettingsAdminState extends State<SettingsAdmin> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with widget values
    fullNameController.text = widget.fullname;
    userNameController.text = widget.username;
    userEmailController.text = widget.email;
    userPasswordController.text = widget.password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Setting'),
      ),
      backgroundColor: Colors.blue, // Set blue background color here
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: fullNameController,
              readOnly: true, // Set to true to make it non-editable
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Full Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),
            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userNameController,
              readOnly: true, // Set to true to make it non-editable
              enabled: false,
              decoration: InputDecoration(
                labelText: 'User Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),

            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),

            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userPasswordController,
              decoration: InputDecoration(
                labelText: 'User Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),
/*
            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'User Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),
              SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userAddressController,
              decoration: InputDecoration(
                labelText: 'Address',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),
            SizedBox(height: 10), // Adjust the height according to your preference
            TextField(
              controller: userPhoneController,
              decoration: InputDecoration(
                labelText: 'Phone :',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // You can change the border color
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the border radius
                ),
              ),
            ),*/

            SizedBox(height: 10), // Adjust the height according to your preference
            ElevatedButton(
              onPressed: () {
                sendDataToServer();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color of the button
              ),
              child: Text('Update Now'),
            ),

          ],
        ),
      ),
    );
  }


  Future<void> sendDataToServer() async {


    Map<String, dynamic> postData = {

      //-------------------------------------------------------
      'fullname' :fullNameController.text ,
      'username' :userNameController.text ,
      'email' :userEmailController.text ,
      'password' :userPasswordController.text ,

    };

    print(fullNameController.text );
    print(userPasswordController.text ); print(userNameController.text ); print(userEmailController.text );



    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/updatepass.php"),
      body: postData,
    );

    if (response.statusCode == 200) {
      print("Server response: ${response.body}");
      // Handle successful response, e.g., show a success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Data has been updated"),

            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error response, e.g., show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to submit data. Please try again."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

}


