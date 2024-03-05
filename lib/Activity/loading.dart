import 'package:flutter/material.dart';
import 'package:mausam_app/Worker/work.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temperature = "Loading....";
  String city = "London";
  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();
    // setState(() {
    //   temperature = instance.temp;
    // });
    // print(instance.air_speed);
    // print(instance.description);
    String tempGet = instance.temp;
    String humidGet = instance.humidity;
    String descGet = instance.description;
    String airGet = instance.air_speed;
    String mainGet = instance.main;
    String icon = instance.icons;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "temp_value": tempGet,
        "humid_value": humidGet,
        "desc_value": descGet,
        "air_value": airGet,
        "main_value": mainGet,
        "icon_value": icon,
        "city_value": city,
      });
    });
    // ignore: use_build_context_synchronously
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if (search != null && search.isNotEmpty) {
      city = search['searchText'];
    }
    startApp(city);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/mLogo.png",
              height: 250.0,
              width: 250.0,
            ),
            const Text(
              "Mausam App",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "Made By Kashish",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
