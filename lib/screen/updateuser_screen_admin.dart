import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/edit_device_admin.dart';

class Userlist extends StatefulWidget {
  @override
  State<Userlist> createState() => _UserlistState();

  static _UserlistState of(BuildContext context) =>
      context.findAncestorStateOfType<_UserlistState>()!;
}

class _UserlistState extends State<Userlist> {
  late Future<List?> _data;

  @override
  void initState() {
    super.initState();
    _data = sendDataToServer();
  }

  Future<List?> sendDataToServer() async {
    final response = await http.get(
      Uri.parse("http://10.131.73.60/sawahcek/getuser.php"),
    );
    return json.decode(response.body);
  }

  Future<void> refreshData() async {
    setState(() {
      _data = sendDataToServer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Of User"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder<List?>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemList(
              list: snapshot.data,
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List? list;

  ItemList({required this.list});

  Future<void> deleteDevice(
      BuildContext context, String id, int index) async {
    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/deleteuser.php"),
      body: {"id": id},
    );

    if (response.statusCode == 200) {
      list?.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User deleted")),
      );
    } else {
      print("Error deleting user: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return Dismissible(
          key: Key(list?[i]['id'].toString() ?? ''),
          direction: DismissDirection.horizontal,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) async {
            bool confirmDelete = await showDeleteConfirmationDialog(context) ?? false;
            if (confirmDelete) {
              deleteDevice(context, list?[i]['id'] ?? '', i);
            }
          },
          confirmDismiss: (direction) async {
            bool confirmDelete = await showDeleteConfirmationDialog(context) ?? false;
            return confirmDelete;
          },

          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Text(list?[i]['username'] +
                    " | " +
                    list?[i]['fullname'] ??
                    ''),
                leading: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: list?[i]['level'] == "Member" ? Colors.blue : list?[i]['level'] == "Admin" ? Colors.red : Colors.transparent,
                  ),

                  child: Icon(
                    Icons.person,

                    color: Colors.white,
                  ),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "${list?[i]['email'] ?? 'Null'}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                trailing: Column(
                  children: [
                    Text(
                        "Contact Number : ${list?[i]['phone']  ?? 'Null'}"),

                  ],
                ),
              ),
            ),
          ),
        );

      },
    );
  }
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this user?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false); // Don't delete
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
            ),
          ],
        );
      },
    );
  }

}


