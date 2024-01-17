import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  Future<List<Map<String, dynamic>>> fetchDataMonthly() async {
    final response = await http.get(Uri.parse('http://10.131.73.60/sawahcek/datamontly.php'));

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
