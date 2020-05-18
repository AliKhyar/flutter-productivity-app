import 'package:flutter/material.dart';
import 'package:productivity_timer_app/timer_model.dart';
import './widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';

void main() => runApp(MyApp());

final double defaultPadding = 5.0;
final CountDownTimer timer = CountDownTimer();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void emptyMethod() {}

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    //print(timer.returnTime(Duration(seconds: 25)));
    return Scaffold(
      appBar: AppBar(
        title: Text('My work timer'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: "Work",
                      onPressed: emptyMethod,
                      size: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      onPressed: emptyMethod,
                      size: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: "Long Break",
                      onPressed: emptyMethod,
                      size: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: TimerModel('00:00', 1),
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = snapshot.data;
                    return Container(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10.0,
                        percent: (timer.percent == null) ? 1 : timer.percent,
                        center: Text(
                            (timer.time == null) ? '00:00' : timer.time,
                            style: Theme.of(context).textTheme.headline4),
                        progressColor: Color(0xff009688),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      onPressed: () => timer.stopTimer(),
                      size: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Restart',
                      onPressed: () => timer.startTimer(),
                      size: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
            ],
          );
        },
      ),
    );
  }
}
