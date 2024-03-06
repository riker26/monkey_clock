import 'dart:async';
import 'dart:math';

class GameController {
  DateTime _currentTime = DateTime.now();
  DateTime? _correctTime;
  int _score = 0;
  Timer? _gameTimer;
  Duration _gameTimeRemaining = Duration(seconds: 15);

  DateTime get currentTime => _currentTime;
  DateTime get correctTime => _correctTime!; // Use non-null assertion operator

  int get score => _score;
  Duration get gameTimer => _gameTimeRemaining;

  void startGame() {
    _score = 0;
    _updateTime();
    _startGameTimer();
    _correctTime = randomTime();
  }

  void _updateTime() {
    _currentTime = DateTime.now();
  }

  DateTime randomTime() {
    return DateTime(
      2024,
      1, //month
      1, //day
      Random().nextInt(11) + 1, //hour
      Random().nextInt(60) + 0, //minute
      Random().nextInt(60) + 0, //second
      0, //millisecond
      0, //microsecond
    );
  }

  void submitGuess(List<String> submittedTimeChars) {
    int submittedHour =
        int.parse(submittedTimeChars[0] + submittedTimeChars[1]);
    int submittedMinute =
        int.parse(submittedTimeChars[3] + submittedTimeChars[4]);

    if (_currentTime.hour == submittedHour &&
        _currentTime.minute == submittedMinute) {
      _score++;
      _updateTime();
    } else {
      _score--;
    }
  }

  void _startGameTimer() {
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _gameTimeRemaining -= Duration(seconds: 1);

      if (_gameTimeRemaining.inSeconds <= 0) {
        _stopGameTimer();
        // Game over, handle game over logic here
      }
    });
  }

  void _stopGameTimer() {
    _gameTimer?.cancel();
  }

  void dispose() {
    _stopGameTimer();
  }
}
