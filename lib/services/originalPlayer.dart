import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rostly/widgets/originalPlayerWidgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final Function next;
  final Function previous;
  // final UniqueKey uniqueKey;

  VideoPlayerScreen({this.url, Key key, this.next, this.previous})
      : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  List<String> urls = [
    // "https://static.videezy.com/system/resources/previews/000/033/549/original/szene10.mp4",
    // "http://techslides.com/demos/sample-videos/small.webm",
    // "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4"
  ];
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.url,
    );
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.pause();
    // _controller.initialize();

    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  // double volumeValue = 2;
  bool videoOptionsVisibility = false;
  bool looping = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 250,
      child: Stack(overflow: Overflow.clip, fit: StackFit.loose, children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              print(videoOptionsVisibility);
              setState(() {
                videoOptionsVisibility = !videoOptionsVisibility;
              });
              print(videoOptionsVisibility);
            },
            child: PlayerScreen(
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
                controller: _controller),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Visibility(
            visible: videoOptionsVisibility,
            child: PlayerOptions(
                controller: _controller,
                functionPrevious: widget.previous,
                function: () {
                  setState(() {
                    videoOptionsVisibility = !videoOptionsVisibility;
                  });
                },
                functionNext: widget.next),
          ),
        ),
        Positioned.fill(
          bottom: 0,
          child: PlayerOptionsBar(
            controller: _controller,
            url: widget.url,
          ),
        ),
      ]),
    );
  }
}

//////////////////**************************************////////////////////////// */
class PlayerOptionsBar extends StatefulWidget {
  @override
  _PlayerOptionsBarState createState() => _PlayerOptionsBarState();
  const PlayerOptionsBar({
    this.url,
    Key key,
    @required VideoPlayerController controller,
  })  : _controller = controller,
        super(key: key);

  final VideoPlayerController _controller;
  final String url;
}

class _PlayerOptionsBarState extends State<PlayerOptionsBar> {
  IconData playIconStatus = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    ProgressSlider slider = new ProgressSlider(controller: widget._controller);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          color: Colors.orange,
          width: 50,
          height: 50,
          child: GestureDetector(
            onTap: () {
              if (widget._controller.value.isPlaying) {
                widget._controller.pause();
                setState(() {
                  playIconStatus = Icons.play_arrow;
                });
              } else {
                widget._controller.play();
                setState(() {
                  playIconStatus = Icons.pause;
                });
              }
            },
            child: Icon(
              playIconStatus,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: ProgressSlider(
              controller: widget._controller,
            ),
            height: 50,
            color: Colors.green.withOpacity(0.8),
          ),
        ),
        ControllerButton(
          child: Icon(
            Icons.fullscreen,
            color: Colors.white,
          ),
          url: widget.url,
          function: () {
            // print(SystemChrome.restoreSystemUIOverlays());

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => VideoFullScreen(
            //               url: widget.url,
            //             )));

            // SystemChrome.setPreferredOrientations([
            //   DeviceOrientation.landscapeRight,
            //   DeviceOrientation.landscapeLeft,
            // ]);
          },
        ),
        ControllerButton(
          child: Icon(
            Icons.loop,
            color: Colors.white,
          ),
          url: widget.url,
          function: () {
            print(widget._controller.value.isLooping);
            var a = widget._controller.value.isLooping;
            widget._controller.setLooping(!a);
            print(widget._controller.value.isLooping);
          },
        ),
        Container(
          width: 50,
          height: 180,
          color: Colors.red.withOpacity(0.8),
          child: Column(children: [
            Expanded(
              child: VolumeSlider(
                controller: widget._controller,
              ),
            ),
            Container(
              color: Colors.blue,
              width: double.infinity,
              height: 50,
              child: Icon(
                Icons.volume_up,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////
class ControllerButton extends StatelessWidget {
  const ControllerButton(
      {Key key, @required this.url, @required this.function, this.child})
      : super(key: key);

  final String url;
  final Function function;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 50,
      height: 50,
      child: GestureDetector(onTap: function, child: child),
    );
  }
}

//////////////////**************************************////////////////////////// */
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    Key key,
    @required Future<void> initializeVideoPlayerFuture,
    @required VideoPlayerController controller,
  })  : _initializeVideoPlayerFuture = initializeVideoPlayerFuture,
        _controller = controller,
        super(key: key);

  final Future<void> _initializeVideoPlayerFuture;
  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: Text("waiting"));
          } else if (snapshot.connectionState == ConnectionState.none) {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: Text("none"));
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: Icon(MaterialIcons.update));
            //  Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

///////////////////*********************************************************//////////////////////////
class ProgressSlider extends StatefulWidget {
  final controller;
  var status;
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
        widget.controller.value.isLooping == true
            ? print("looping")
            : print("not looping");
        print(
            "${(value.position.hashCode / 1000000).round().toDouble()} out of ${((widget.controller.value.duration.hashCode / 1000000).round()).toDouble()} ");
        if ((value.position.hashCode / 1000000).round().toDouble() ==
            ((widget.controller.value.duration.hashCode / 1000000).round())
                .toDouble()) {
          print("the end");
        } else
          print("still running");

        return Slider(
          // value: _controller.value.position.hashCode.round() / 1000000,
          // value: _currentSliderValue,
          value: (widget.controller.value.position.hashCode.round() / 1000000)
              .toDouble(),
          min: 0,
          max: (((widget.controller.value.duration.hashCode / 1000000))
              .round()
              .toDouble()),
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
        );
      },
    );
  }
}
