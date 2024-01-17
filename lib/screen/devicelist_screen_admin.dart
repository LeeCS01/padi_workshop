import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/edit_device_admin.dart';

class Devicelist extends StatefulWidget {
  @override
  State<Devicelist> createState() => _DevicelistState();

  static _DevicelistState of(BuildContext context) =>
      context.findAncestorStateOfType<_DevicelistState>()!;
}

class _DevicelistState extends State<Devicelist> {
  late Future<List?> _data;

  void refreshDataCallback() {
    refreshData();
  }

  @override
  void initState() {
    super.initState();
    _data = sendDataToServer();
  }

  Future<List?> sendDataToServer() async {
    final response = await http.get(
      Uri.parse("http://10.131.73.60/sawahcek/getdevice.php"),
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
        title: Text("List Of Device"),
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
              refreshCallback: refreshDataCallback,
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
  final VoidCallback refreshCallback;

  ItemList({required this.list, required this.refreshCallback});

  Future<void> deleteDevice(
      BuildContext context, String deviceID, int index) async {
    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/deletedevice.php"),
      body: {"DeviceID": deviceID},
    );

    if (response.statusCode == 200) {
      list?.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Device deleted")),
      );
    } else {
      print("Error deleting device: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return Dismissible(
          key: Key(list?[i]['DeviceID'].toString() ?? ''),
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
              deleteDevice(context, list?[i]['DeviceID'] ?? '', i);
            }
          },
          confirmDismiss: (direction) async {
            bool confirmDelete = await showDeleteConfirmationDialog(context) ?? false;
            return confirmDelete;
          },

          child: GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => EditDevicePage(
                    deviceID: list?[i]['DeviceID'] ?? '',
                  ),
                ),
              );
              // After returning from EditDevicePage, refresh the data
              refreshCallback();
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  title: Text(list?[i]['DeviceID'] +
                      " | " +
                      list?[i]['slname'] ??
                      ''),
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(
                      Icons.perm_device_info_rounded,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      color: getStatusColor(list?[i]['RealTimeStatus']),
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
                          "Real Time Scala : ${list?[i]['RealTimeScala'] + " Meter" ?? 'Null'}"),
                      Text("Last Update : ${list?[i]['LastUpdate'] ?? 'Null'}"),
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
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this item?"),
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
