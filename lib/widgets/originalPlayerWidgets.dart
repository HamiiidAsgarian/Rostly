import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:video_player/video_player.dart';

class PlayerOptions extends StatefulWidget {
  PlayerOptions({this.controller, this.function});
  final controller;
  final Function function;
  @override
  _PlayerOptionsState createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends State<PlayerOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      FlatButton(
        onPressed: () {
          // if (widget.controller.value.isPlaying == true) {
          //   widget.controller.pause();
          // } else {
          //   widget.controller.play();
          // }
          widget.function();
          setState(() {});
        },
        child: ClipOval(
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue.withOpacity(0.5),
            child: (widget.controller.value.isPlaying == true)
                ? Icon(Icons.pause, color: Colors.white)
                : Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
      FlatButton(
        onPressed: () {
          if (widget.controller.value.isPlaying == true) {
            widget.controller.pause();
          } else {
            widget.controller.play();
          }
          setState(() {});
        },
        child: ClipOval(
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue.withOpacity(0.5),
            child: (widget.controller.value.isPlaying == true)
                ? Icon(Icons.pause, color: Colors.white)
                : Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
      FlatButton(
        onPressed: () {
          if (widget.controller.value.isPlaying == true) {
            widget.controller.pause();
          } else {
            widget.controller.play();
          }
          setState(() {});
        },
        child: ClipOval(
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue.withOpacity(0.5),
            child: (widget.controller.value.isPlaying == true)
                ? Icon(MaterialIcons.pause, color: Colors.white)
                : Icon(
                    MaterialIcons.skip_next,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    ]);
  }
}

class VolumeSlider extends StatefulWidget {
  final controller;
  VolumeSlider({this.controller});

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double volumeValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 3,
        child: Container(
          width: 150,
          // height: 100,
          child: Slider(
              min: 0,
              max: 1,
              value: volumeValue,
              onChanged: (e) {
                // print(e);
                setState(() {
                  volumeValue = e;
                });
                widget.controller.setVolume(e);
              }),
        ));
  }
}

class ProgressSlider extends StatefulWidget {
  final controller;

  ProgressSlider({this.controller});

  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  Duration _currentSliderValueDuration;

  String sliderValueStaus;

  @override
  Widget build(BuildContext context) {
    // double durationToSecond(Duration time) {
    //   double hour = time.inHours / 3600;
    //   double minute = time.inMinutes / 60;
    //   double second = time.inSeconds.toDouble();

    //   // print(hour + minute + second);
    //   return (hour + minute + second);
    // }

    Duration secondToDuration(seconds) {
      int hours = (seconds / 3600).toInt();
      int rowMinute = (seconds % 3600).toInt();
      int minutes = (rowMinute ~/ 60);
      int rowSeconds = (rowMinute % 60).toInt();
      Duration zz =
          Duration(hours: hours, minutes: minutes, seconds: rowSeconds);
      // print("$hours : $minutes : $rowSeconds");
      // print(zz);

      return (zz);
    }

    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, VideoPlayerValue value, child) {
        print((value.position.hashCode / 1000000).round());
        return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 20,
            // width: 500,
            color: Colors.blue.withOpacity(0.2),
            child: Row(children: [
              Slider(
                // value: _controller.value.position.hashCode.round() / 1000000,
                // value: _currentSliderValue,
                value:
                    widget.controller.value.position.hashCode.round() / 1000000,
                min: 0,
                max: widget.controller.value.duration.hashCode / 1000000,
                divisions: (1000),
                label: _currentSliderValueDuration.toString().split('.')[0],
                onChangeStart: (e) {
                  setState(() {
                    sliderValueStaus = "changing";
                  });
                },
                onChanged: (double e) {
                  setState(() {
                    // _currentSliderValue = e;
                    _currentSliderValueDuration = secondToDuration(e);
                    Duration destinationTime = secondToDuration(e);
                    widget.controller.seekTo(destinationTime);
                  });
                },
                onChangeEnd: (e) {
                  setState(() {
                    // _currentSliderValue = e;
                  });
                  Duration destinationTime = secondToDuration(e);
                  widget.controller.seekTo(destinationTime);
                  widget.controller.play();
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
