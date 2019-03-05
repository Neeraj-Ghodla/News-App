import 'package:flutter/material.dart';
import 'package:news_app/category.dart';

class HomePage extends StatefulWidget {
  final String country;

  HomePage(this.country);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        actions: <Widget>[
          IconButton(
            icon: Text("${widget.country.toUpperCase()}"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Select a Country?"),
                    actions: <Widget>[
                      IconButton(
                        icon: Text("US"),
                        onPressed: () => {
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage("us"),
                                ),
                              ),
                            },
                      ),
                      IconButton(
                        icon: Text("IN"),
                        onPressed: () => {
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage("in"),
                                ),
                              ),
                            },
                      ),
                      IconButton(
                        icon: Text("NZ"),
                        onPressed: () => {
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage("nz"),
                                ),
                              ),
                            },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Category(widget.country, category),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            if (currentTab == 1) {
              category = "technology";
            } else if (currentTab == 2) {
              category = "business";
            } else if (currentTab == 3) {
              category = "entertainment";
            } else {
              category = "";
            }
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.view_headline,
                color: Colors.black,
              ),
              title: Text(
                "Headlines",
                style: TextStyle(color: Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.phone_android,
                color: Colors.black,
              ),
              title: Text(
                "Technology",
                style: TextStyle(color: Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
                color: Colors.black,
              ),
              title: Text(
                "Bussiness",
                style: TextStyle(color: Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_movies,
                color: Colors.black,
              ),
              title: Text(
                "Entertainment",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
