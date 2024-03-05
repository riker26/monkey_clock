// lib/sprites/keypad.dart

import 'package:flutter/material.dart';

class CustomTimeInput extends StatefulWidget {
  const CustomTimeInput({Key? key}) : super(key: key);

  @override
  _CustomTimeInputState createState() => _CustomTimeInputState();
}

//Colors:
const Color keypadButtonsColor = Color.fromARGB(255, 255, 255, 255);
const Color keypadTextColor = Color.fromARGB(255, 255, 255, 255);

class _CustomTimeInputState extends State<CustomTimeInput> {
  String inputTime = "0:00";

  void _onKeyPress(String value) {
    setState(() {
      if (value == 'CE') {
        inputTime = "0:00";
      } else {
        if (inputTime == "0:00") {
          inputTime = "";
        }
        inputTime += value;
        if (inputTime.length == 2) {
          inputTime += ':'; // Automatically add a colon after the hour input
        }
        if (inputTime.length > 5) {
          inputTime = inputTime.substring(0, 5); // Limit input to 5 characters
        }
      }
    });
  }

  Widget _keypadButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: OutlinedButton(
        onPressed: () => _onKeyPress(value),
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(value,
            style: TextStyle(fontSize: 24, color: keypadButtonsColor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          inputTime,
          style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: keypadTextColor),
        ),

        Container(
          height: screenHeight * 0.45,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio:
                  1.4, // Keep this to maintain square buttons, if desired
              mainAxisSpacing: 4, // Spacing between rows
              crossAxisSpacing: 4, // Spacing between columns
            ),
            itemCount: 12, // Total number of buttons
            itemBuilder: (context, index) {
              // Define button labels
              List<String> buttons = [
                '1',
                '2',
                '3',
                '4',
                '5',
                '6',
                '7',
                '8',
                '9',
                'CE',
                '0',
                ''
              ];
              return _keypadButton(buttons[index]);
            },
          ),
        ),
      ],
    );
  }
}
