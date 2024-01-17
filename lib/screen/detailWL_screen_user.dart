import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sawahcek/screen/ereport.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sawahcek/screen/wlreport_screen_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailWaterLevel extends StatefulWidget {
  final List? list;
  final int? index;
  final String id;
  final String userid;

  DetailWaterLevel({required this.index, required this.list, required this.id,required this.userid});

  @override
  _DetailWaterLevelState createState() => _DetailWaterLevelState();
}

class _DetailWaterLevelState extends State<DetailWaterLevel> {



  List<Map<String, dynamic>> snapshotData = [];
  List<Map<String, dynamic>> data =[];
  String rtscale="0.0";
  String status="null";
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Initialize the timer
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      realtimeupdate();
      getNewDataAndUpdateUI(); // Fetch new data and update the UI

      // Optionally, you can call other methods or perform additional actions here
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<Null> realtimeupdate() async {
    final response = await http
        .post(Uri.parse("http://10.131.73.60/sawahcek/realtimeupdate.php"));
    if (response.statusCode == 200) {
      print("new data update");

    }
  }



  Future<List<Map<String, dynamic>>> fetchData() async {
    String deviceID = widget.list?[widget.index!]['DeviceID'];
    Map<String, dynamic> postData = {
      'deviceID': deviceID,
    };
    final response = await http.post(
       Uri.parse("http://10.131.73.60/sawahcek/dataone.php"),
      body: postData,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data =
      List<Map<String, dynamic>>.from(jsonResponse);

      // Convert datetime01 to DateTime and purata to double
      data.forEach((item) {
        item['datetime01'] = DateTime.parse(item['datetime01']);
        print(item['datetime01']);
        item['purata'] = double.parse(item['purata']);
        print(item['purata']);
      });

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }



  //============================================

  Future<List<Map<String, dynamic>>> getnewData() async {
    realtimeupdate();
    String deviceID = widget.list?[widget.index!]['DeviceID'];
    Map<String, dynamic> postData = {
      'deviceID': deviceID,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/getdetailsdevice.php"),
      body: postData,
    );


    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data =
      List<Map<String, dynamic>>.from(jsonResponse);

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  //=====================================================================
  Future<List<Map<String, dynamic>>> fetchDataMonthly() async {
    String deviceID = widget.list?[widget.index!]['DeviceID'];
    Map<String, dynamic> postData = {
      'deviceID': deviceID,
    };
    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/datamonthly.php"),
      body: postData,
    );


    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);

      // Convert datetime01 to DateTime and purata to double
      data.forEach((item) {
        item['Bulan'] = DateTime.parse(item['Bulan']);
        print(item['Bulan']);
        item['PurataBulanan'] = double.parse(item['PurataBulanan']);
        print(item['PurataBulanan']);
      });

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //=====================================================================*/


  Future<Map<String, dynamic>> getNewDataAndUpdateUI() async {
    // Fetch new data and update the UI
    List<Map<String, dynamic>> newData = await getnewData();
    setState(() {
      data = newData;
    });

    Map<String, dynamic> result = {
  //    'RealTimeScala': data[0]['RealTimeScala'].toString(),
      'RealTimeStatus': data[0]['RealTimeStatus'],
    rtscale : data[0]['RealTimeScala'],
    };


    return result;
  }



  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.list?[widget.index!]['DeviceID'])),
        body: SingleChildScrollView(
          child: Container(
            height: 1700.0,
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 30.0)),
                    Text("REAL TIME WATER LEVEL MONITORING SYSTEM ",
                        style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                    Padding(padding: const EdgeInsets.only(top: 10.0)),
                FutureBuilder(
                  future: getnewData(),
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      List<Map<String, dynamic>> data = snapshot.data!;

                      // Access your details (location, deviceID, latitude, longitude)
                      String location = data[0]['Location'];
                      String deviceID = data[0]['DeviceID'] ;
                      String latitude = data[0]['Latitud'] ;
                      String longitude = data[0]['Longitud'];
                      String wl =data[0]['RealTimeStatus'];
                      String mtr =data[0]['RealTimeScala'];
                      rtscale=mtr;
                      String date = data[0]['LastUpdate'];




                      // Use the details to build your UI
                      return Column(
                        children: [
                          GFProgressBar(
                            percentage: updatescala(),
                            lineHeight: 45,
                            width: 450,
                            alignment: MainAxisAlignment.spaceEvenly,
                            backgroundColor: Colors.black12,
                            progressBarColor: getProgressBarColor(
                               wl ),
                          ),
                          Text(
                              "Real Time Status: "+wl,
                              style:
                              TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                          Text(

                              "Real Time Scala: ${rtscale + " Meter" }",
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text(

                              "Updated by: "+ date,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Padding(padding: const EdgeInsets.only(top: 10.0)),
                          Text(
                              "Weekly Analysis",
                              style:
                              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          FutureBuilder(
                            future: fetchData(),
                            builder: (context,
                                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 285,
                                  child: Image.asset("images/try.png"),
                                );
                                // Replace 'assets/no_data_image.png' with the path to your image asset
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    color: Colors.grey,
                                    child: SfCartesianChart(
                                      primaryXAxis: DateTimeAxis(
                                        intervalType: DateTimeIntervalType.days,
                                      ),
                                      primaryYAxis: NumericAxis(),
                                      series: <CartesianSeries<Map<String, dynamic>,
                                          DateTime>>[
                                        LineSeries<Map<String, dynamic>, DateTime>(
                                          dataSource: snapshotData.isNotEmpty
                                              ? snapshotData
                                              : snapshot.data!,
                                          xValueMapper: (Map<String, dynamic> data, _) =>
                                          data['datetime01'],
                                          yValueMapper: (Map<String, dynamic> data, _) =>
                                          data['purata'],
                                          name: 'Purata',
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true),
                                          enableTooltip: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0)),
                          Text(
                              "Monthly Analysis",
                              style:
                              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          FutureBuilder(
                            future: fetchDataMonthly(),
                            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Loading indicator while fetching data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Text('No data available');
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    color: Colors.grey, // Set the background color of the chart
                                    child: SfCartesianChart(
                                      primaryXAxis: DateTimeAxis(
                                        intervalType: DateTimeIntervalType.months, // Set the interval type to days
                                      ),
                                      primaryYAxis: NumericAxis(),
                                      series: <CartesianSeries<Map<String, dynamic>, DateTime>>[
                                        ColumnSeries<Map<String, dynamic>, DateTime>(
                                          dataSource: snapshot.data!,
                                          xValueMapper: (Map<String, dynamic> data, _) => data['Bulan'],
                                          yValueMapper: (Map<String, dynamic> data, _) => data['PurataBulanan'],
                                          name: 'PurataBulanan',
                                          dataLabelSettings: DataLabelSettings(isVisible: true), // Add this line for data labels
                                          enableTooltip: true, // Enable tooltip for the series
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),

                          Padding(padding: const EdgeInsets.only(top: 10.0)),


                          DataTable(
                            columns: [
                              DataColumn(label: Text('Information')),
                              DataColumn(label: Text('Details')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('Location')),
                                DataCell(Text(location)),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Device ID')),
                                DataCell(Text(deviceID)),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Latitude')),
                                DataCell(Text(latitude)),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Longitude')),
                                DataCell(Text(longitude)),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('RealTime Scale')),
                                DataCell(Text(mtr+" Meter")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Updated by')),
                                DataCell(Text(date)),
                              ]),



                              // Add more rows as needed
                            ],
                          ),
                        ],
                      );

                    }
                  },
                ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    if ((data.isNotEmpty ? data[0]['RealTimeStatus'] : getNewDataAndUpdateUI()).toString() == "Low Level" || data[0]['RealTimeStatus'] == "High Level")
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Ereport( list: widget.list,
                                  index: widget.index,
                                  id:widget.id,
                              userid:widget.userid)),
                            );
                          },
                          child: Text('Report'),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),

              ],
                ),
              ),
            ),
          ),
        ),
      );
    }





  double updatescala() {

    //print(data.isNotEmpty ? data[0]['RealTimeScala'] + " Meter" : getNewDataAndUpdateUI());

    double? scalaValue = double.tryParse(rtscale);

    if (scalaValue != null) {
      double result =
          scalaValue / double.tryParse(widget.list?[widget.index!]['Depth'])!;

      if (result > 1.0) {
        result = 1.0;
      }


      return result;
    } else {


      return 0.0;
    }
  }

  Color getProgressBarColor(String value) {
    if (value == "Low Level") {
      return Colors.red;
    } else if (value == "Normal Level") {
      return Colors.yellow;
    } else if(value == "High Level"){
      return Colors.green;
    }else
      return Colors.black;
  }
}
