import 'package:flutter/material.dart';
import 'package:flutter_yandex_mapkit/maps_screen.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MapsScreen(),
      ),
    );
  }
}
