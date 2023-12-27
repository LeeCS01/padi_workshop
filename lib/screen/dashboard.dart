import 'dart:io';

import 'package:sawahcek/screen/ereport.dart';

import 'package:sawahcek/screen/newdevicereq.dart';
import 'package:sawahcek/screen/newpassuser.dart';
import 'package:sawahcek/screen/reportcentre.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawahcek/screen/notif_screen_user.dart';
import 'package:sawahcek/screen/setting_screen_user.dart';
import 'package:sawahcek/screen/adminreportcentre.dart';




class DashboardS extends StatelessWidget {
  DashboardS({Key? key}) : super(key: key);

  Widget itemDashboard(String title, IconData iconData, Color background,
      BuildContext context, Widget Function(BuildContext) routeBuilder) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: routeBuilder),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(1, 0, 63, 103),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color:Colors.blue,
                    spreadRadius: 2,
                    blurRadius: 35)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue[900], shape: BoxShape.circle),
                child: Icon(iconData, color: Colors.white,size: 100,),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 25.0,// Set your desired font color
                ),
              )
              ,
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  title: Text(
                    "Real Time Water Level Monitoring System",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Sawah Cek",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 900,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  )),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Notification', CupertinoIcons.news,
                      Colors.blueAccent, context, (context) => DashboardS()),
                  itemDashboard('WaterLevel', CupertinoIcons.slider_horizontal_below_rectangle,
                      Colors.lightBlue, context, (context) => DashboardS()),
                  itemDashboard('E-Report', CupertinoIcons.person_3_fill,
                      Colors.blueGrey, context, (context) => Reportcentre()),
                  itemDashboard('My Settings', CupertinoIcons.settings_solid,
                      Colors.blue, context, (context) => DashboardS()),
                  itemDashboard('My Admin Report', CupertinoIcons.waveform_circle,
                      Colors.blue, context, (context) => AdminReportcentre()),
                  itemDashboard('My Admin Report', CupertinoIcons.add_circled_solid,
                      Colors.blue, context, (context) => DashboardS()),
                  itemDashboard('New Password', CupertinoIcons.lock_circle,
                      Colors.blue, context, (context) => NewPassReq()),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          exit(0);
        },
        child: const Icon(Icons.arrow_back,color: Colors.white,),
        backgroundColor: Colors.blue[900],
      ),
    );
  }

  WaterLevel() {}
}
