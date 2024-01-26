import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/detailNotif.dart';
import 'package:sawahcek/screen/edit_device_admin.dart';
import 'package:sawahcek/screen/editnotif_admin.dart';


class Notiflist extends StatefulWidget {
  @override
  State<Notiflist> createState() => _NotiflistState();

  static _NotiflistState of(BuildContext context) =>
      context.findAncestorStateOfType<_NotiflistState>()!;
}

class _NotiflistState extends State<Notiflist> {
  late Future<List?> _data;

  @override
  void initState() {
    super.initState();
    _data = sendDataToServer();
  }

  Future<List?> sendDataToServer() async {
    final response = await http.get(
      Uri.parse("http://10.131.73.13/sawahcek/getnotifdevice_admin.php"),
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
        title: Text("List Of Notification"),
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

  Future<void> deleteNotif(
      BuildContext context, String NotifID, int index) async {
    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/deleteNotif_admin.php"),
      body: {"NotifID": NotifID},
    );

    if (response.statusCode == 200) {
      list?.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notif deleted")),
      );
    } else {
      print("Error deleting Notif: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return Dismissible(
          key: Key(list?[i]['NotifID'].toString() ?? ''),
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
              deleteNotif(context, list?[i]['NotifID'] ?? '', i);
            }
          },
          confirmDismiss: (direction) async {
            bool confirmDelete = await showDeleteConfirmationDialog(context) ?? false;
            return confirmDelete;
          },

          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailNotif(list: list, index: i),
              ),
            ),
            onLongPress: () => navigateToEditPage(context, list?[i]['NotifID'] ?? ''),

            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  title: Text(list?[i]['NotifID'] +
                      " | " +
                      list?[i]['RecordedStatus'] ??
                      ''),
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: list?[i]['TargetUser'] != "ALL" ? Colors.blueAccent : list?[i]['TargetUser'] == "ALL" ? Colors.orange : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.perm_device_info_rounded,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      color: getStatusColor(list?[i]['RecordedStatus']),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "${list?[i]['RealTimeStatus'] ?? 'Null'}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Text(
                          "Date Issues : ${list?[i]['Date'] + " Meter" ?? 'Null'}"),
                      Text("Issued at : ${list?[i]['Time'] ?? 'Null'}"),
                    ],
                  ),
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
          title: Text("Delete Notification From User ?"),
          content: Text("Are you sure you want to delete this notification?"),
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

  void navigateToEditPage(BuildContext context, String NotifID) {
    print(NotifID);
    Navigator.of(context).push(
      MaterialPageRoute(

        builder: (BuildContext context) => EditNotifAdmin(NotifID: NotifID),
      ),
    );
  }


}

Color getStatusColor(String? status) {
  switch (status) {
    case 'High Level':
      return Colors.red;
    case 'Normal Level':
      return Colors.yellow;
    case 'Low Level':
      return Colors.green;
    default:
      return Colors.black;
  }
}
