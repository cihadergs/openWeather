// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/splash_screen.dart';

void main() => runApp(MaterialApp(
      title: "Hava Durumu Uygulaması",
      home: splash_screen(),
    ));

class Home extends StatefulWidget {
  final String? sehirAd;

  Home({this.sehirAd});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humdity;
  var windSpeed;
  var feelsLike;

  var karli = "Karli";

  //Future getWeather(lat, long) async {
  Future getWeather(cityName) async {
    var url2 =
        "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=a04acad548ffa09d0df63565b9590f67&lang=tr";
    //var url =
    //"https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&units=metric&appid=a04acad548ffa09d0df63565b9590f67&lang=tr";

    http.Response response = await http.get(Uri.parse(url2));
    //"https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=a04acad548ffa09d0df63565b9590f67&lang=tr"));
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.feelsLike = results['main']['feels_like'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humdity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];

      //lat = position.latitude;
      //long = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    //this.getWeather('','');

    this.getWeather(widget.sehirAd);
  }

  havalariCevir() {
    if (currently == 'Sunny') {
      return 'Güneşli';
    }
    if (currently == 'Snow') {
      return 'Karlı';
    }
    if (currently == 'Rain') {
      return 'Yağmurlu';
    }
    if (currently == 'Haze') {
      return 'Puslu';
    } else {
      return 'Bulutlu';
    }
  }

  resimleriGetir() {
    if (currently == 'Sunny') {
      return "images/sunny.jpg";
    }
    if (currently == 'Snow') {
      return "images/snow.jpg";
    }
    if (currently == 'Rain') {
      return "images/rainy.jpg";
    }
    if (currently == 'Haze') {
      return "images/haze.jpg";
    } else {
      return "images/haze.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(resimleriGetir()), fit: BoxFit.cover),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    widget.sehirAd ?? "Seçilen Şehir",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + " \u2103" : "Yükleniyor",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    havalariCevir(),

                    //currently != null ? currently.toString() : "Yükleniyor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Sıcaklık"),
                  trailing: Text(
                    temp != null ? temp.toString() + " \u2103" : "Yükleniyor",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerFull),
                  title: Text("Hissedilen Sıcaklık"),
                  trailing: Text(
                    feelsLike != null
                        ? feelsLike.toString() + " \u2103"
                        : "Yükleniyor",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Durum"),
                  trailing: Text(
                    description != null ? description.toString() : "YÜkleniyor",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Nem"),
                  trailing: Text(
                    humdity != null ? humdity.toString() : "Yükleniyor",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Rüzgar"),
                  trailing: Text(
                    windSpeed != null ? windSpeed.toString() : "Yükleniyor",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
