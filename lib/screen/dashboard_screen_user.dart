import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sawahcek/screen/WL_screen.dart';
import 'package:sawahcek/screen/notif_screen_user.dart';
import 'package:sawahcek/screen/profile_screen_admin.dart';
import 'package:sawahcek/screen/profile_screen_user.dart';
import 'package:sawahcek/screen/realtimewl_screen_user.dart';
import 'package:sawahcek/screen/waterlevel_screen.dart';
import 'package:sawahcek/screen/reportcentre.dart';
import 'package:sawahcek/screen/ereport.dart';

class DashboardUser extends StatelessWidget {
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;

  DashboardUser({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
  });

  Widget itemSettings(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ProfileUser(
            id: id.toString(),
            fullname: fullname,
            username: username,
            email: email,
            password: password,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.settings_solid,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          'My Settings',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    ),
  );

  Widget itemWaterLevel(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => ParasAir(
          id: id.toString(),
          username: username,
        )),
      );
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.alarm,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          'Water Level',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    ),
  );

  Widget itemDashboard(String title, IconData iconData, Color background,
      BuildContext context, Widget Function(BuildContext) routeBuilder) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: routeBuilder),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: background, shape: BoxShape.circle),
              child: Icon(iconData, color: Colors.white, size: 30),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "images/a.png",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Image.asset("images/GUI.png"),
                ),

                const SizedBox(height: 20),

                const Text(
                  "SawahCheck",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),

                const Text(
                  "Real Time Water Level Monitoring System",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Hi, ',
                      ),
                      TextSpan(
                        text: username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "DASHBOARD",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          Container(
            height: 160,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(21, 127, 193, 20),
              borderRadius: BorderRadius.circular(50),
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 30,
              children: [
                itemDashboard(
                    'Notification',
                    CupertinoIcons.mail,
                    Colors.blueGrey,
                    context,
                        (context) =>Notif(id: id.toString(),
                          username: username,) ),
                itemDashboard(
                    'Water Level',
                    CupertinoIcons.alarm,
                    Colors.blueGrey,
                    context,
                        (context) => Ereport(id:id.toString()) ),
                itemDashboard(
                    'E-Report',
                    CupertinoIcons.thermometer,
                    Colors.blueGrey,
                    context,
                        (context) =>Reportcentre(id: '', username: '',)),
                itemSettings(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




