import 'package:flutter/material.dart';
import 'package:shopingapp/resources/URLResources.dart';
import 'package:shopingapp/utility/ApiHandler.dart';
class ProductWithDatabaseHandlerScreens extends StatefulWidget {
  const ProductWithDatabaseHandlerScreens({Key? key}) : super(key: key);

  @override
  State<ProductWithDatabaseHandlerScreens> createState() => _ProductWithDatabaseHandlerScreensState();
}

class _ProductWithDatabaseHandlerScreensState extends State<ProductWithDatabaseHandlerScreens> {
  Future<List>? allproducts;

  Future<List> getdata() async {
    await ApiHandler.getcall(URLResources.VIEW_PRODUCTS).then((json) {
      return json;
    });

    return [];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = getdata();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: FutureBuilder(
          future: allproducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text("No Data Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lightGreen.shade100,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Name:-" +
                                  snapshot.data![index]["name"]
                                      .toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));



  }
}
