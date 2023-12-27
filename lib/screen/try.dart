import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Try extends StatefulWidget {
  @override
  State<Try> createState() => _TryState();
}

class _TryState extends State<Try> {
  List<CategoryData> _categoryData = [];
  CategoryData? selectedCate;

  //Get all categories from API
  Future<Null> getData() async {
    final response = await http.post(Uri.parse("http://10.131.78.75/sawahcek/getdevice.php"));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var jsonResult = jsonDecode(response.body);
        setState(() {
          for (Map user in jsonResult) {
            _categoryData.add(CategoryData.fromJson(user));
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                child: DropdownButtonFormField(
                  hint: Text("Select Category"),
                  value: selectedCate,
                  onChanged: (CategoryData? value) {
                    setState(() {
                      selectedCate = value;
                    });
                  },
                  items: _categoryData
                      .map(
                          (CategoryData cate) => DropdownMenuItem<CategoryData>(
                        child: Text(cate.cname),
                        value: cate,
                      ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryData {
  var cid;
  var cname;

  CategoryData({this.cid, this.cname});

  factory CategoryData.fromJson(Map<dynamic, dynamic> json) {
    return CategoryData(
      cid: json['DeviceID'],
      cname: json['Location'],
    );
  }
}
