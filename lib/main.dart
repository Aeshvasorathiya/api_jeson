

import 'dart:convert';
import 'dart:developer';
import 'package:api_jeson/student.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()
{
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}
class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  final dio = Dio();

 

  Future getHttp() async {
    final response = await dio.get('https://systudent.000webhostapp.com/view_api.php');
   log("${response.data}");
    dynamic m=response.data;
    log("${m}");

    return m;
  }
  Future getdata()
  async {
    var url = Uri.https('systudent.000webhostapp.com', 'view_api.php');
    var response = await http.get(url);
    Map m=jsonDecode(response.body);
    log("${m}");
    return m;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: FutureBuilder(future: getdata(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
            {
              if(snapshot.hasData)
              {
                Map m=snapshot.data;
                List l=m['res'];
                return ListView.builder(itemCount: l.length,
                  itemBuilder: (context, index) {
                   // print("${l[index]}");
                    print("${jsonEncode(l[index])}");
                    student s=student.fromMap(l[index]);
                     print(s);
                    return ListTile(
                      title: Text("${l[index]['name']}"),
                      subtitle: Text("${l[index]['contact']}"),
                      trailing: Text("${l[index]['id']}"),
                    );
                  },);
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }

            }
          else
            {
              return Center(child: CircularProgressIndicator(),);
            }
        },
      ),
    );
  }
}
