// lib/sprites/keypad.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monkey_clock/pages/clock_page.dart';

class CustomTimeInput extends StatefulWidget {
  final Future<bool> Function(List<String>) onSubmitTime;
  const CustomTimeInput({Key? key, required this.onSubmitTime})
      : super(key: key);

  @override
  _CustomTimeInputState createState() => _CustomTimeInputState();
  
}

//Colors:
const Color keypadButtonsColor = Color.fromARGB(255, 255, 255, 255);
const Color keypadTextColor = Color.fromARGB(255, 255, 255, 255);

//Special Icons:
const IconData backspaceButton = Icons.backspace;
const IconData submitButton = Icons.send;

class _CustomTimeInputState extends State<CustomTimeInput> {
  List<String> timeChars = ['0', '0', ':', '0', '0'];

  bool isValid12hrTime(List<String> timeChars) {
    if (int.parse(timeChars[0]) >= 1 && int.parse(timeChars[1]) > 2) {
      print('Invalid time: ${timeChars.join()}');
      return false;
    } else if (int.parse(timeChars[0]) > 2) {
      print('Invalid time: ${timeChars.join()}');
      return false;
    } else if (int.parse(timeChars[3]) > 5) {
      print('Invalid time: ${timeChars.join()}');
      return false;
    } else if (int.parse(timeChars[0]) > 1) {
      print('Invalid time: ${timeChars.join()}');
      return false;
    } else if (int.parse(timeChars[1]) == 0) {
      print('Invalid time: ${timeChars.join()}');
      return false;
    }
    return true;
  }

void _onKeyPress(dynamic value) async {
    // Mark the method as async
    if (value == backspaceButton) {
      setState(() {
        // Move previous digits to the right
        timeChars[4] = timeChars[3];
        timeChars[3] = timeChars[1];
        timeChars[1] = timeChars[0];
        timeChars[0] = '0';
      });
    } else if (value == submitButton) {
      // First, check if the time is valid
      if (isValid12hrTime(timeChars)) {
        // If valid, then asynchronously check if the time is correct
        bool isCorrect = await widget.onSubmitTime(timeChars);
        if (isCorrect) {
          print('Correct time!!!: ${timeChars.join()}');
        } else {
          print('Incorrect time!!!: ${timeChars.join()}');
        }
      } else {
        print('Invalid time: ${timeChars.join()}');
      }
    } else {
      setState(() {
        // Update the time from the back, skipping the colon
        timeChars[0] = timeChars[1];
        timeChars[1] = timeChars[3];
        timeChars[3] = timeChars[4];
        timeChars[4] = value;
    });
    }
}

  Widget _keypadButton(dynamic value) {
    bool isIcon = value is IconData;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        child: OutlinedButton(
          onPressed: () => _onKeyPress(value),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromARGB(5, 255, 255, 255),
          ),
          child: isIcon
              ? Icon(value, color: keypadButtonsColor, size: 24)
              : Text(
                  value,
                  style: TextStyle(fontSize: 24, color: keypadButtonsColor),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // Add a border to the container that wraps the Column
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.red, //make the border visible for debugging
          //   width: 2,
          // ),
          ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.5,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: '', //add something later
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: keypadTextColor,
                ),
                children: timeChars.asMap().entries.map((entry) {
                  int index = entry.key;
                  String char = entry.value;
                  Color textColor = keypadTextColor; // Default color

                  // Check if the current '0' is leading (preceded only by other '0's and ':')
                  bool isLeadingZero = char == '0';
                  for (int i = 0; i < index; i++) {
                    if (timeChars[i] != '0' && timeChars[i] != ':') {
                      isLeadingZero = false;
                      break;
                    }
                  }

                  // Set color to grey if it's a leading zero
                  textColor = isLeadingZero ? Colors.grey : keypadTextColor;

                  return TextSpan(
                    text: char,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.42,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                  top: 25, bottom: 10, left: 40, right: 40),
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
                List<dynamic> buttons = [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  backspaceButton,
                  '0',
                  submitButton
                ];
                return _keypadButton(buttons[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
