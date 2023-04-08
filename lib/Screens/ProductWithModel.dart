import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/models/Products.dart';
import 'package:shopingapp/resources/URLResources.dart';

class ProductWithModel extends StatefulWidget {
  const ProductWithModel({Key? key}) : super(key: key);

  @override
  State<ProductWithModel> createState() => _ProductWithModelState();
}

class _ProductWithModelState extends State<ProductWithModel> {
  List<Products>? allproductdata;
  bool isloded = false;
  getdata() async {
    setState(() {
      isloded = true;
    });
    Uri url = Uri.parse(URLResources.VIEW_PRODUCTS);
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      var json = jsonDecode(responce.body.toString());
      setState(() {
        allproductdata =
            json.map<Products>((obj) => Products.fromJson(obj)).toList();
        isloded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: (isloded)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allproductdata!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(allproductdata![index].name.toString()),
                    Image.network(allproductdata![index].image.toString(),
                        height: 100.0),
                  ],
                );
              },
            ),
    );
  }
}
