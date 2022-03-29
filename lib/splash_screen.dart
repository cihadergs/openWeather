// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:geolocator/geolocator.dart';

class splash_screen extends StatefulWidget {
  splash_screen({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<splash_screen> {
  String? _sehirAd;

  /*Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getPosition() async {
    Position position = await _determinePosition();
    setState(() {
      this.koordinat = position.latitude.toString();
      this.koordinat2 = position.longitude.toString();
    });
  } */

  /* _navhome() async {
    Position position = await _determinePosition();


    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }*/

  _evedon() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  sehirAd: _sehirAd,
                )));
  }

  @override
  void initState() {
    super.initState();

    //_navhome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.location_on,
                size: 46,
                color: Colors.blue,
              ),
            ),
            Text(
              "Bugün Hava Nasıl ?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) => _sehirAd = val,
              decoration:
                  InputDecoration(labelText: 'Lütfen bir şehir adı yazınız...'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: builder))
                    _evedon();
                  },
                  child: Text("Şimdi Öğren")),
            ),
          ],
        ),
      ),
    );
  }
}
