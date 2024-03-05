import 'dart:math';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  // int count = 1;
  List<String> dataList = [];
  List<String> city_names = ["Mumbai", "Surat", "London", "Chennai", "Delhi"];
  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    // searchController.addListener(onSearchTextChanged as VoidCallback);
    print("This is an init state");
  }

  @override
  void dispose() {
    super.dispose();
    // searchController.dispose();
    print("STATE DESTROYED");
  }

  void onSearchTextChanged(String value) {
      // String searchText = searchController.text;
      // print(searchText);
    setState(() {
      filteredSuggestions = city_names
          .where((suggestion) =>
              suggestion.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

void displaySearchedData(String searchText) {
    print("Searched Text: $searchText");
  }
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String display_data = (info?["temp_value"]?.toString()) ?? "";
    final _random = Random();
    var random_city = city_names[_random.nextInt(city_names.length)];
    String icon = info?["icon_value"] ?? "";
    String city = info?["city_value"] ?? "";
    String description = info?["desc_value"] ?? "";
    String airSpeed = (info?["air_value"]?.toString()) ?? "";
    String humid = info?["humid_value"] ?? "";

    if (display_data == "No") {
      print("No");
    } else {
      display_data = (info?["temp_value"]?.toString() ?? "").substring(0, 4);
      airSpeed = (info?["air_value"]?.toString() ?? "").substring(0, 4);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: const LinearGradient(colors: [
            Colors.blueAccent,
            Colors.lightBlueAccent,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueAccent, Colors.lightBlueAccent])),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44)),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") == "") {
                            print("Blank Search");
                          } else {
                            setState(() {
                              
                              String searchText = searchController.text;
                              // print(city_names);
                              // if(!dataList.contains(searchText)){
                              // }
                                city_names.add(searchText);
                              displaySearchedData(searchController.text);
                            // Navigator.pushNamed(context, "/loading", arguments: {
                            //   'searchText': searchController.text,
                            // });
                            });
                            
                            
                          }
                        },
                        child: Container(
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: onSearchTextChanged,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $random_city"),
                        ),
                      ),
                    ],
                  ),
                ),
                if (filteredSuggestions.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: filteredSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredSuggestions[index]),
                          onTap: () {
                            setState(() { 
                              searchController.text =
                                  filteredSuggestions[index];
                                  // displaySearchedData(searchController.text);
                            });
                          },
                        );
                      },
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "$description",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "In $city",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 13),
                        padding: const EdgeInsets.all(26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$display_data",
                              style: TextStyle(
                                  fontSize: 55, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "C",
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        margin: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$airSpeed",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "km/hr",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        margin: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$humid",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Percent",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 65,
                ),
                Padding(padding: EdgeInsets.all(15)),
                const Text(
                  "Made By Kashish",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "Data Provided by Openweathermap.org",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
