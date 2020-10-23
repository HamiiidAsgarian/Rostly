import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:video_player/video_player.dart';

class PlayerOptions extends StatefulWidget {
  PlayerOptions(
      {this.controller,
      this.function,
      this.functionNext,
      this.functionPrevious});
  final controller;
  final Function function;
  final Function functionNext;
  final Function functionPrevious;

  @override
  _PlayerOptionsState createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends State<PlayerOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 60,
        height: 60,
        child: FlatButton(
          color: Colors.blue.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            // if (widget.controller.value.isPlaying == true) {
            //   widget.controller.pause();
            // } else {
            //   widget.controller.play();
            // }
            widget.functionPrevious();
            setState(() {});
          },
          child: Icon(
            Icons.skip_previous,
            color: Colors.white,
          ),
        ),
      ),
      Container(
        width: 80,
        height: 80,
        child: FlatButton(
          // materialTapTargetSize: MaterialTapTargetSize(),
          color: Colors.blue.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            if (widget.controller.value.isPlaying == true) {
              widget.controller.pause();
            } else {
              widget.controller.play();
            }
            setState(() {});
          },
          child: (widget.controller.value.isPlaying == true)
              ? Icon(Icons.pause, color: Colors.white)
              : Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
        ),
      ),
      Container(
        width: 60,
        height: 60,
        child: FlatButton(
          color: Colors.blue.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            // if (widget.controller.value.isPlaying == true) {
            //   widget.controller.pause();
            // } else {
            //   widget.controller.play();
            // }
            widget.functionNext();
            setState(() {});
          },
          child: Icon(
            Icons.skip_next,
            color: Colors.white,
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
  double volumeValue = 0.1;
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
