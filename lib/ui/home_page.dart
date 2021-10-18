import 'dart:convert';

import 'package:dars40/models/homepage_data.dart';
import 'package:dars40/ui/view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexofnav = 0;
  List showingList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
            activeIcon: Icon(Icons.house),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
            activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_open_rounded),
            label: "",
            activeIcon: Icon(Icons.menu_sharp),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_flags_sharp),
            label: "",
            activeIcon: Icon(Icons.flag_sharp),
          )
        ],
        currentIndex: currentIndexofnav,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: (v) {
          setState(() {
            currentIndexofnav = v;
          });
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Countries",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Find a place to see a weather",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  onChanged: (v) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Type to search....",
                    hintStyle: TextStyle(fontSize: 14),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Nearby Countries",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "View All",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Near from ",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 210,
                  child: FutureBuilder(
                      future: getCountries(),
                      builder: (context, AsyncSnapshot<List<Coutries>> snap) {
                        var data = snap.data;
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (snap.connectionState ==
                            ConnectionState.done) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: showingList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewPage(
                                          index:  index,
                                          cityname: showingList[index]
                                              ["cityname"][0],
                                          img:
                                              "https://source.unsplash.com/random/$index",
                                          name: showingList[index]["name"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://source.unsplash.com/random/$index"),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 10,
                                            bottom: 20,
                                            child: Text(
                                              showingList[index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 38,
                                            left: 10,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text("${index * 2}"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Top Rated",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "View All",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 210,
                child: FutureBuilder(
                  future: getCountries(),
                  builder: (context, AsyncSnapshot<List<Coutries>> snap) {
                    var data = snap.data;
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (snap.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: showingList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPage(
                                      index: index,
                                      cityname: showingList[index]["cityname"]
                                          [0],
                                      img:
                                          "https://source.unsplash.com/random/$index",
                                      name: showingList[index]["name"],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, left: 10),
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://source.unsplash.com/random/${index * 3}"))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 10,
                                      bottom: 20,
                                      child: Text(
                                        showingList[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 19),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 38,
                                      left: 10,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Text("${index * 2}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Coutries>> getCountries() async {
    var url = Uri.parse("https://restcountries.com/v3.1/region/asia");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var list1 = (json.decode(res.body) as List)
          .map((e) => Coutries.fromJson(e))
          .toList();
      showingList = [];
      list1.forEach((person) {
        var element = person.name!.common;
        var capital = person.capital;
        if (element.toString().toLowerCase().contains(
              _controller.text.toString().toLowerCase(),
            )) {
          showingList.add({"name": element, "cityname": capital});
        }
      });
      return list1;
    } else {
      throw Exception("Xatolar Bor");
    }
  }
}
