import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  double hourInseconds = 0;
  double minutesInSeconds = 0;
  double seconds = 0;
  double totalSeconds = 0;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      "https://static.videezy.com/system/resources/previews/000/037/964/original/baby_dog13.mp4",
    );
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
    setState(() {});

    super.initState();
  }

  durationToSecond(Duration time) {
    double hour = time.inHours / 3600;
    double minute = time.inMinutes / 60;
    double second = time.inSeconds.toDouble();

    print(hour + minute + second);
    return (hour + minute + second);
  }

  Duration secondToDuration(seconds) {
    int hours = (seconds / 3600).toInt();
    int rowMinute = (seconds % 3600).toInt();
    int minutes = (rowMinute ~/ 60);
    int rowSeconds = (rowMinute % 60).toInt();
    Duration zz = Duration(hours: hours, minutes: minutes, seconds: rowSeconds);
    print("$hours : $minutes : $rowSeconds");
    print(zz);

    return (zz);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  // double maincurrentSliderValue = 0.0;
  var _currentSliderValue = 0.0;
  Duration _currentSliderValueDuration;

  double sliderValueStaus;

  // Duration destinationTimes;

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////////

    var i = ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, VideoPlayerValue value, child) {
        return Slider(
            // value: _controller.value.position.hashCode.round() / 1000000,
            // value: _currentSliderValue,
            value: (_controller.value.isPlaying == true)
                ? _controller.value.position.hashCode.round() / 1000000
                : _currentSliderValue,
            min: 0,
            max: _controller.value.duration.hashCode.round() / 1000000,
            divisions: 100,
            label: _currentSliderValueDuration.toString().split('.')[0],
            onChangeStart: (e) {
              // (_controller.value.isPlaying == true)
              //     ? _controller.value.position.hashCode.round() / 1000000
              //     : _currentSliderValue;
              _controller.pause();
            },
            onChangeEnd: (e) {
              // sliderValueStaus =
              //     _controller.value.position.hashCode.round() / 1000000;
              Duration destinationTime = secondToDuration(e);
              _controller.play();
              _controller.seekTo(destinationTime);
            },
            onChanged: (double e) {
              var a = secondToDuration(e);
              print("onChanged $e means $a");
              print(e);

              setState(() {
                _currentSliderValue = e;
                _currentSliderValueDuration = secondToDuration(e);
              });
            });
      },
    );
    ////////////////////////////////////////////////////////////

    // var a = Text("data").data;
    return Scaffold(
        appBar: AppBar(
            // title: Text(i),
            ),
        // Use a FutureBuilder to display a loading spinner while waiting for the
        // VideoPlayerController to finish initializing.
        body: Column(children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          RaisedButton(onPressed: () {
            if (_controller.value.isPlaying == true) {
              _controller.pause();
            } else {
              _controller.play();
            }
          }),
          i,
        ]));
  }
}
