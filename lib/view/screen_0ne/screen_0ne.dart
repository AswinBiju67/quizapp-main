import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quizapp/view/last_screen/last_screen.dart';
import 'dart:async';

class ScreenOne extends StatefulWidget {
  final dynamic topic;
  const ScreenOne({super.key, this.topic});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  late Timer _timer;
  int _timeLeft = 10;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _goToNextQuestion();
        }
      });
    });
  }

  void _goToNextQuestion() {
    _timer.cancel();
    if (currentQuestionIndex < widget.topic.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        _startTimer();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LastScreen(score: score,quiz: widget.topic,),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _timeLeft / 10;
    double questionProgress = (currentQuestionIndex + 1) / widget.topic.length;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "${currentQuestionIndex + 1} / ${widget.topic.length}",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LinearPercentIndicator(
              lineHeight: 14.0,
              percent: questionProgress,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 10.0,
                            percent: progress,
                            center: Text(
                              '$_timeLeft\nseconds',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.center,
                            ),
                            progressColor: Colors.blue,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.topic[currentQuestionIndex]["Question"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (selectedAnswerIndex ==
                            widget.topic[currentQuestionIndex]["Answerindex"])
                          Lottie.asset('assets/animation/Animation_popper.json'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      if (selectedAnswerIndex == null) {
                        setState(() {
                          selectedAnswerIndex = index;
                          if (selectedAnswerIndex ==
                              widget.topic[currentQuestionIndex]["Answerindex"]) {
                            score++;
                          }
                        });
                      }
                      Future.delayed(Duration(milliseconds: 1000), () {
                      _goToNextQuestion();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: getcolor(index), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.topic[currentQuestionIndex]["Options"][index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Color getcolor(int clickindex) {
    if (selectedAnswerIndex != null) {
      if (widget.topic[currentQuestionIndex]["Answerindex"] == clickindex) {
        return Colors.green;
      }
    }
    if (selectedAnswerIndex == clickindex) {
      if (selectedAnswerIndex ==
          widget.topic[currentQuestionIndex]["Answerindex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}
