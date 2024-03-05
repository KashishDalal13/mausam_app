import 'package:http/http.dart';
import 'dart:convert';
class worker
{

  String location;

  //Constructor

  worker({required this.location})
  {
    location = this.location;
  }


  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icons;

  
  Future<void> getData() async
  {
    try{
    Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=bcb59e3ad483098a1e4e3cc2cce6fb1a"));
    Map data = jsonDecode(response.body);
    print(data);


    //Getting Temp,Humidiy
    Map temp_data = data['main'];
    String getHumidity = temp_data['humidity'].toString();
    double getTemp = temp_data['temp'] - 273.15;

//Getting air_speed
    Map wind = data['wind'];
    double getAir_speed = wind["speed"]/0.27777777777778;


    //Getting Description
    List weather_data = data['weather'];
    Map weather_main_data = weather_data[0];
    String getMain_des = weather_main_data['main'];
    String getDesc = weather_main_data["description"];
    String geticons = weather_main_data['icon'];
    // print(geticons);


    //Assigning Values
    temp = getTemp.toString();
    humidity = getHumidity;
    air_speed = getAir_speed.toString();
    description = getDesc;
    main = getMain_des;
    icons = geticons;
    }catch(e){
      temp = "No";
      humidity = "No";
      air_speed = "No";
      description = "Can't find Data";
      main = "No";
      icons = "09d";
    }
  }
}