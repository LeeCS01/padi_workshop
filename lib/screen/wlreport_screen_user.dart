import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawahcek/screen/detailWL_screen_user.dart';

class Wlreportuser extends StatefulWidget {
  final String id;


  Wlreportuser({
    required this.id,
  });

  @override
  State<Wlreportuser> createState() => _WlreportuserState();
}
String userid =" ";
class _WlreportuserState extends State<Wlreportuser> {
  late Future<List?> _data;
  late Timer _timer;


  @override
  void initState() {
    userid=widget.id;
    super.initState();
    _data = sendDataToServer();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      refreshData();
    });
  }

  Future<List?> sendDataToServer() async {
    final response = await http.post(
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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time Water Level Monitoring"),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        // Extracting the id from the list or providing a default value if not available
        String id = list?[i]['DeviceID'] ?? '';

        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailWaterLevel(list: list, index: i, id: id,userid:userid),
                // Pass the id to the DetailWaterLevel widget
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(list?[i]['DeviceID'] + " AT " + list?[i]['Location'] ?? ''),
                leading: Icon(Icons.developer_board),
                subtitle: Text("Location : ${list?[i]['Location'] ?? ''}"),
                trailing: Text("Real Time Status : ${list?[i]['RealTimeStatus'] ?? ''}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
