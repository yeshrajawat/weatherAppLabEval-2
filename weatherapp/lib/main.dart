import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
MaterialApp (
  title: "Weather App",
  home:Home(),
)
);
class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState( ){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
 TextEditingController name = new TextEditingController();
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  String city = "Jaipur";
  String apikey = '89c391678f289337ace893bdf39b1a98';
  Future getWeather() async {
    http.Response response = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&units=Metric&appid=$apikey"));
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity= results['main']['humidity'];
      this.windSpeed= results['wind']['speed'];
    });
  }

@override void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }


  @override 
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
             Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    child: TextField(
                      controller: name,
                      autocorrect: true,
                      decoration: const InputDecoration(
                        hintText: 'City Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2),
                        ),
                        labelText: 'City',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        String tempcity = name.text.toString();
                        setState(() {
                          city = tempcity;
                          getWeather();
                        });
                      },
                      child: const Text(
                        'Get',
                        style: TextStyle(color: Colors.black),
                      )),
          Container(
            height:MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom:10.0),
                  child: Text(
                    "Currently in $city",
                    style: TextStyle(
                       color:Colors.white,
                       fontSize: 14.0,
                       fontWeight: FontWeight.w600)
                  ), 
                  
                ),
                Text(temp != null ? temp.toString() + "\u00B0":"Loading",
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600
                )
                ,),
                Padding(
                  padding: EdgeInsets.only(bottom:10.0),
                  child: Text(
                    currently != null ? currently.toString() + "\u00B0" : "Loading",
                    style: TextStyle(
                       color:Colors.white,
                       fontSize: 14.0,
                       fontWeight: FontWeight.w600)
                  )
                  )
              ],
            ),

          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0":"Loading",)
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Description"),
                    trailing: Text(description != null ? description.toString() + "\u00B0":"Loading",)
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity!= null ? humidity.toString() + "\u00B0":"Loading",)
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed!= null ? windSpeed.toString() + "\u00B0":"Loading",)
                  )
                ],
              ) 
            ,)
             )
        ],
      ),
    );
  }
}