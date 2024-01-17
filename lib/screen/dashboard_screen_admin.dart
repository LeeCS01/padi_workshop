import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sawahcek/screen/dam_screen.dart';
import 'package:sawahcek/screen/profile_screen_admin.dart';
import 'package:sawahcek/screen/adminreportcentre.dart';

class DashboardAdmin extends StatelessWidget {
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;

  DashboardAdmin({
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
          builder: (context) => ProfileAdmin(
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

  Widget registerDam(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const Dam()),
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
            CupertinoIcons.map,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          'Register Dam',
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
                const SizedBox(height: 10),

                const Text(
                  "Welcome to Admin Page",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),
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
                "ADMIN DASHBOARD",
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
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 30,
              children: [
                registerDam(context),
                itemDashboard(
                    'E-Report',
                    CupertinoIcons.thermometer,
                    Colors.blueGrey,
                    context,
                        (context) => AdminReportcentre(id: '',)),
                itemSettings(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaterLevel extends StatelessWidget {
  const WaterLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Water Level'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Coming Soon'),
        ),
      ),
    );
  }
}

