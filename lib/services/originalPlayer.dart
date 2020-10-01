import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rostly/screens/videoFullScreen.dart';
import 'package:rostly/widgets/originalPlayerWidgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  // final UniqueKey uniqueKey;

  VideoPlayerScreen({this.url, Key key}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  List<String> urls = [
    "https://static.videezy.com/system/resources/previews/000/033/549/original/szene10.mp4",
    "http://techslides.com/demos/sample-videos/small.webm",
    "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4"
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
  bool videoOptionsVisibility = true;

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
              functionPrevious: () {
                print("previous");
              },
              function: () {
                setState(() {
                  videoOptionsVisibility = !videoOptionsVisibility;
                });
              },
              functionNext: () {
                print("next");
              },
            ),
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

class PlayerOptionsBar extends StatelessWidget {
  const PlayerOptionsBar({
    this.url,
    Key key,
    @required VideoPlayerController controller,
  })  : _controller = controller,
        super(key: key);

  final VideoPlayerController _controller;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          color: Colors.orange,
          width: 50,
          height: 50,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: ProgressSlider(
              controller: _controller,
            ),
            height: 50,
            color: Colors.green.withOpacity(0.8),
          ),
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
          child: GestureDetector(
            onTap: () {
              // print(SystemChrome.restoreSystemUIOverlays());

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => VideoFullScreen(
                            url: url,
                          )));
              // SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.landscapeRight,
              //   DeviceOrientation.landscapeLeft,
              // ]);
            },
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          color: Colors.pink,
          width: 50,
          height: 50,
          child: Icon(
            Icons.loop,
            color: Colors.white,
          ),
        ),
        Container(
          width: 50,
          height: 180,
          color: Colors.red.withOpacity(0.8),
          child: Column(children: [
            Expanded(
              child: VolumeSlider(
                controller: _controller,
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
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

///////////////////*********************************************************//////////////////////////
