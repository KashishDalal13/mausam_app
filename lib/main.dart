import 'package:flutter/material.dart';
// import 'Activity/home.dart';
// import 'Activity/loading.dart';
// import 'Activity/location.dart';
import 'package:mausam_app/Activity/home.dart';
import 'package:mausam_app/Activity/loading.dart';
import 'package:mausam_app/Activity/location.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/" :(context) => const Loading(),
      "/home" :(context) => const Home(),
      "/loading" :(context) => const Loading(),
    },
  ));
}


