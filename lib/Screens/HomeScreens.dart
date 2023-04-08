import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/resources/URLResources.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  Future<List>? allproductdata;
  Future<List> getdata() async {
    Uri url = Uri.parse(URLResources.VIEW_PRODUCTS);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var json = jsonDecode(responce.body.toString());
      return json;
    } else {
      print("error");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproductdata = getdata();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body:FutureBuilder(
        future: allproductdata,
        builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data!.length == 0){
            return Center(
              child: Text("No Data Found"),
            );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(snapshot.data![index]["name"].toString()),
                    Image.network(snapshot.data![index]["image"].toString(),height: 100.0),
                  ],
                );
            },);
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },)
    );
  }
}
