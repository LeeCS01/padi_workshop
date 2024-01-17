import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/dashboard.dart';

class NewDeviceReq extends StatefulWidget {
  @override
  _NewDeviceReqState createState() => _NewDeviceReqState();


  final String id;

  NewDeviceReq({
    required this.id,
  });
}

class _NewDeviceReqState extends State<NewDeviceReq> {
  TextEditingController farmerIDController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController contactnumController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  void initState() {
    super.initState();
    farmerIDController.text = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW DEVICE REQUEST'),
      ),
      backgroundColor: Colors.blue, // Set blue background color here
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20), // Adjust the height according to your preference
            TextField(
              controller: farmerIDController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Farmer ID',
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
              controller: detailsController,
              decoration: InputDecoration(
                labelText: 'Details',
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
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
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
              controller: contactnumController,
              decoration: InputDecoration(
                labelText: 'Contact Num',
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
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Description',
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
            ),
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
            Text(combine()),
          ],
        ),
      ),
    );
  }
  String combine(){
    var var1 = contactnumController.text;
    var space = " ";
    var var2 = locationController.text;
    var var3 = emailController.text;
    var var4 = descController.text;
    var var5=detailsController.text;

    String combinedText = var1 +space+ var2 +space+ var3 +space+ var4+space+var5 ;
    print(combinedText); // Output: Hello world!
    return combinedText;
  }

  String info=" ";
  Future<void> sendDataToServer() async {
    info=combine();
    Map<String, dynamic> postData = {

    //-------------------------------------------------------
    'FarmerID' :farmerIDController.text ,
    'Details' :info ,

    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/newdevicereq.php"),
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
