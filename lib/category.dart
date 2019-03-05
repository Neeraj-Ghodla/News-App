import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:news_app/news.dart';

class Category extends StatefulWidget {
  final String category;
  final String country;

  Category(this.country, [this.category = ""]);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Future fetchData() async {
    await Future.delayed(Duration(seconds: 0));
    var response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=${widget.country}&category=${widget.category}&apiKey=dac5ec6701a04b92a0602fff575c41b6");

    var jsonData;
    if (response.statusCode == 200) {
      String responseBody = response.body;
      jsonData = json.decode(responseBody);
    } else {
      print("Something went wrong!");
    }
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        leading: Icon(Icons.view_headline),
                        title: Text(
                            "${snapshot.data['articles'][index]['title']}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsPage(
                                "${snapshot.data['articles'][index]['source']['name']}",
                                  "${snapshot.data['articles'][index]['url']}"),
                            ),
                          );
                        },
                      ),
                  itemCount: snapshot.data['articles'].length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      onRefresh: fetchData,
    );
  }
}