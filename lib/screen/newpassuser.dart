import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NewPassReq extends StatefulWidget {
  @override
  _NewPassReqState createState() => _NewPassReqState();
}

class _NewPassReqState extends State<NewPassReq> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORGET PASSWORD REQUEST'),
      ),
      backgroundColor: Colors.white, // Set blue background color here
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20), // Adjust the height according to your preference
            TextFormField(
              controller: emailController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Adjust the height according to your preference
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: conpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(passwordController.text==conpasswordController.text)
                  {
                    sendDataToServer();
                  }
                else{
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("ERROR"),
                        content: Text("YOUR PASSWORD ARE NOT THE SAME,PLEASE TRY AGAIN"),

                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }


              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color of the button
                onPrimary: Colors.white, // Text color of the button
              ),
              child: Text('Submit Now'),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> sendDataToServer() async {

    Map<String, dynamic> postData = {

      //-------------------------------------------------------
      'email' :emailController.text ,
      'password' :passwordController.text ,

    };

    final response = await http.post(
      Uri.parse("http://10.131.78.75/sawahcek/updatepass.php"),
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
            content: Text("Data has been insert"),

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
