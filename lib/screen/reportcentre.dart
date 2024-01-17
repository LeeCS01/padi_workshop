import 'dart:convert';
import 'package:sawahcek/screen/detailonprogress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Reportcentre extends StatefulWidget {
  final String id;
  final String username;

  Reportcentre({
    required this.id,
    required this.username,
  });


  @override
  _ReportcentreState createState() => _ReportcentreState();
}

class _ReportcentreState extends State<Reportcentre> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //list array

  List? Qlist = [];
  List? OnList=[];
  List? DoneList=[];


  Future<List?> sendDataToServer() async {
    Map<String, dynamic> postData = {
      'TargetUser': widget.id,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/getnotifdevice.php"),
      body: postData,
    );

    return json.decode(response.body);
  }




  //Data Diambil Qlist
  Future<List?> getQlist() async {
    Map<String, dynamic> postData = {
      'FarmerID': widget.id,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/getdatareqaduan.php"),
      body: postData,
    );

    return json.decode(response.body);
  }


//---------------------------------------------------------------------------------------------------
  //Data Diambil Onlist
  Future<List?> getOnlist() async {
    Map<String, dynamic> postData = {
      'FarmerID': widget.id,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/getdataonprogress.php"),
      body: postData,
    );

    return json.decode(response.body);
  }


//---------------------------------------------------------------------------------------------------
  //Data Diambil Onlist
  Future<List?> getDonelist() async {
    Map<String, dynamic> postData = {
      'FarmerID': widget.id,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/getdatadone.php"),
      body: postData,
    );

    return json.decode(response.body);
  }


//---------------------------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    String farmerID = widget.id;
    _tabController = TabController(length: 3, vsync: this);
    getQlist().then((value) {
      setState(() {
        Qlist = value ?? []; // Use null-aware operator to handle null values
      });});

    getOnlist().then((value) {
      setState(() {
        OnList=value ?? [];
      });});

    getDonelist().then((value) {
      setState(() {
        DoneList= value?? [];
      });});


  }
//------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                  Text(
                    "REALTIME WATER LEVEL",
                    style: TextStyle(color: Colors.white, fontSize: 40, wordSpacing: 10,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "MONITORING SYSTEM",
                    style: TextStyle(color: Colors.white, fontSize: 40, wordSpacing: 10,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    width: 400,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning, color: Colors.white,size: 60,),
                        Text(
                          " REPORT CENTRE",
                          style: TextStyle(color: Colors.white, fontSize: 30, wordSpacing: 2,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: TabBar(
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.indigo,
              controller: _tabController,
              tabs: [
                Tab(
                  icon: Icon(Icons.mail_outline,size: 40,),
                  text:"IN REQUEST" ,
                ),
                Tab(
                  icon: Icon(Icons.timelapse,size: 40,),
                  text: "ON PROGRESS",
                ),
                Tab(
                  icon: Icon(Icons.done,size: 40,),
                  text: "DONE",
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: Qlist?.length ?? 0,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Detailonprogress(list: Qlist, index: i),
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(Qlist?[i]['CaseID'] ?? ''),
                              leading: Icon(Icons.request_page),
                              subtitle: Text("TypeCase : ${Qlist?[i]['TypeCase'] ?? ''}"),
                              trailing:Text("Issues at : ${Qlist?[i]['DateIssues'] +"  ${Qlist?[i]['TimeIssues']}" ?? ''}"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child:ListView.builder(
                      itemCount: OnList?.length ?? 0,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => Detailonprogress(list: OnList, index: i),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                title: Text(OnList?[i]['CaseID'] ?? ''),
                                leading: Icon(Icons.timelapse),
                                subtitle: Text("TypeCase : ${OnList?[i]['TypeCase'] ?? ''}"),
                                trailing:Text("Issues at : ${OnList?[i]['DateIssues'] +"  ${OnList?[i]['TimeIssues']}" ?? ''}"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child:ListView.builder(
                      itemCount: DoneList?.length ?? 0,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => Detailonprogress(list: DoneList, index: i),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                title: Text(DoneList?[i]['CaseID'] ?? ''),
                                leading: Icon(Icons.done_all),
                                subtitle: Text("TypeCase : ${DoneList?[i]['TypeCase'] ?? ''}"),
                                trailing:Text("Issues at : ${DoneList?[i]['DateIssues'] +"  ${DoneList?[i]['TimeIssues']}" ?? ''}"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
