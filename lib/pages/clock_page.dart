import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monkey_clock/pages/drawer.dart';

class clockPage extends StatelessWidget {
  const clockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clock',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(133, 5, 5, 5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      drawer: const AppDrawer(),
    );
  }
}

//function generates random time
String randomTime() {
  var hour = (DateTime.now().hour).toString();
  var minute = (DateTime.now().minute).toString();
  var second = (DateTime.now().second).toString();
  return hour + ':' + minute + ':' + second;
}

//Drawer for the clock page
