import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monkey_clock/pages/drawer.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:monkey_clock/sprites/keypad.dart';


class clockPage extends StatefulWidget {
  const clockPage({super.key});

  @override
  State<clockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<clockPage> {
  final TextEditingController _controller = TextEditingController();

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

    
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            //insert analog clock
            padding: EdgeInsets.only(top: 25),
            child: AnalogClock(
              useMilitaryTime: false,
              hourHandColor: Colors.white,
              minuteHandColor: Colors.lightBlue,
              showTicks: true,
              showNumbers: true,
              showAllNumbers: true,
              numberColor: Colors.white,
              digitalClockColor: Colors.white,
              width: 270,
              height: 270,
            ),
          ),
          Expanded(
            child: CustomTimeInput(),
          ),
          // Padding(
          //   //insert input field here
          //   padding: EdgeInsets.all(20.0),
          //   child: TextField(
          //     controller: _controller,
          //     keyboardType: TextInputType.number,
          //     decoration: const InputDecoration(
          //       hintText: "Enter the time (e.g., 1020 for 10:20)",
          //       border: OutlineInputBorder(),
          //     ),
          //   ),
          // ),
        ],
      ),
      




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
