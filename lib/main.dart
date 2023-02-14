import 'package:flutter/material.dart';
import 'package:geolocator_geocoding/views/screens/details_page.dart';
import 'package:geolocator_geocoding/views/screens/homepage.dart';
import 'package:geolocator_geocoding/views/screens/location_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff0A2647),
        secondary: const Color(0xff0A2647),
      )),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail_page':(context)=>const DetailsPage(),
        'location_page':(context)=>const LocationPage(),
      },
    );
  }
}
