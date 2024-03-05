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

  DateTime theTime = DateTime(2019, 1, 1, 9, 12, 15); //9:12:15 AM (24-hr time)

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            //insert analog clock
            padding: EdgeInsets.only(top: 25),
            child: AnalogClock(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0,
                    color: const Color.fromARGB(255, 218, 218, 218)),
                color: Color.fromARGB(255, 46, 46, 46),
                shape: BoxShape.circle,
              ),
              useMilitaryTime: false,
              hourHandColor: Colors.white,
              minuteHandColor: Colors.lightBlue,
              showTicks: true,
              showNumbers: true,
              showAllNumbers: true,
              showSecondHand: false,
              numberColor: Colors.white,
              isLive: false,
              digitalClockColor: Colors.white,
              width: 270,
              height: 270,
              datetime: theTime,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: CustomTimeInput(onSubmitTime: handleSubmitTime),
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

  Future<bool> handleSubmitTime(List<String> submittedTimeChars) async {
    int submittedHour =
        int.parse(submittedTimeChars[0] + submittedTimeChars[1]);
    int submittedMinute =
        int.parse(submittedTimeChars[3] + submittedTimeChars[4]);

    return theTime.hour == submittedHour && theTime.minute == submittedMinute;
  }





}

//function generates random time
String randomTime() {
  var hour = (DateTime.now().hour).toString();
  var minute = (DateTime.now().minute).toString();
  var second = (DateTime.now().second).toString();
  return hour + ':' + minute + ':' + second;
}



bool isCorrectTime(List<String> timeChars, DateTime time) {
  //convert timeChars to DateTime
  int guessHour = int.parse(timeChars[0] + timeChars[1]);
  int guessMinute = int.parse(timeChars[3] + timeChars[4]);

  if (time.hour == guessHour && time.minute == guessMinute) {
    print('TRUE Guess: $guessHour:$guessMinute');
    return true;
  } else {
    print('False Guess: $guessHour:$guessMinute');
    return false;
  }
}

//Drawer for the clock page
//xcrun simctl boot A1BA12B8-068D-4DA0-8ABF-A326A9A6C2D5