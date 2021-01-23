import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://randomuser.me/api/?results=50";
  List userData;
  bool _loading = true;

  Future getData() async {
    var response = await http.get(Uri.encodeFull(url),headers: {"Accept":"application/json"});

    List data = json.decode(response.body)['results'];
    
    setState(() {
      userData = data;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
      child: _loading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: userData == null ? 0 : userData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Image(
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              userData[index]['picture']['thumbnail']
                          ),
                        ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            userData[index]['name']['first'] + " " + userData[index]['name']['last'],
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                  ),
                );
              }),
    )
    );
  }
}
