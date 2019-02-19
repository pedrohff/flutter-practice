import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'widgets/image_list.dart';
import 'package:pics/src/models/image_model.dart';

class App extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {

  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    print('x');
    counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    print(response);
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState((){
      images.add(imageModel);
      print(images[0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        appBar: AppBar(
          title: Text('Flutter App!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(
              Icons.add
          ),
        ),
      ),
    );
  }

}
