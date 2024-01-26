import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/dashboard.dart';

class usersettings extends StatefulWidget {
  @override
  _usersettingsState createState() => _usersettingsState();



  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;

  usersettings({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
  });
}

class _usersettingsState extends State<usersettings> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
//  TextEditingController addressController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();


  void initState() {
    super.initState();
    getData();
   emailController.text = widget.id;
    fullnameController.text = widget.fullname;
    usernameController.text = widget.username;
    passController.text = widget.password;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      backgroundColor: Colors.blue, // Set blue background color here
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20), // Adjust the height according to your preference
            TextField(
              controller: usernameController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Username',
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

            SizedBox(height: 20), // Adjust the height according to your preference
            TextField(
              controller: fullnameController,
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
            SizedBox(height: 20),
           /* TextField(
              controller:addressController,
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

            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
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

            SizedBox(height: 20),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                labelText: 'Password',
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

            SizedBox(height: 20),
         /*   TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
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
            SizedBox(height: 20), // Adjust the height according to your preference
            ElevatedButton(
              onPressed: () {
                sendDataToServer();

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color of the button
              ),
              child: Text('Submit Now'),
            ),

          ],
        ),
      ),
    );
  }


  Future<Map<String, dynamic>?> getData() async {
    print(widget.id);

    // Assuming widget.id is a String

    Map<String, dynamic> postData = {
      'email': widget.id,
    };

    try {
      final response = await http.post(
        Uri.parse("http://10.131.73.13/sawahcek/getuser.php"),
        body: postData,
      );

      // Check if the response status code is 200 OK
      if (response.statusCode == 200) {
        dynamic decodedData = json.decode(response.body);

        // Check if the decoded data is a list
        if (decodedData is List) {
          // Handle list data here, if needed
          print("Received a list, but expected a map");
          return null;  // or handle it accordingly
        }

        // Assuming decodedData is a map
        Map<String, dynamic> responseData = decodedData;

        print( responseData['fullname']);
        fullnameController = responseData['fullname'];
        //addressController = responseData['address'];
        usernameController = responseData['username'];
        passController = responseData['password'];
        //phoneController = responseData['phone'];

        // Return the decoded response data
        return responseData;
      } else {
        // If the response status code is not 200 OK, handle the error accordingly
        print("Error: ${response.statusCode}");
        return null; // or throw an exception
      }
    } catch (error) {
      // Handle exceptions that may occur during the HTTP request
      print("Exception: $error");
      return null; // or throw an exception
    }
  }


  Future<void> sendDataToServer() async {

    Map<String, dynamic> postData = {

      //-------------------------------------------------------
      'fullname' :fullnameController.text ,
      'username' :usernameController.text ,
      'email' :emailController.text ,
     // 'phone' :phoneController.text ,
      //'address' :addressController.text,
      'password' :passController.text ,

    };

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
