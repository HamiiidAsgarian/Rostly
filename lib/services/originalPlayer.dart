import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rostly/widgets/originalPlayerWidgets.dart';
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
  // double hourInseconds = 0;
  // double minutesInSeconds = 0;
  // double seconds = 0;
  // double totalSeconds = 0;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      "http://techslides.com/demos/sample-videos/small.webm",
    );
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
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
    return Scaffold(
        body: Visibility(
      // visible: ,
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Stack(fit: StackFit.loose, children: [
            Center(
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
                    function: () {
                      setState(() {
                        videoOptionsVisibility = !videoOptionsVisibility;
                      });
                    }),
              ),
            ),
            RaisedButton(onPressed: () {
              _controller.setLooping(true);
            }),
            Positioned(
              right: 0,
              bottom: 0,
              // alignment: Alignment.centerRight,
              child: VolumeSlider(
                controller: _controller,
              ),
            ),
            ProgressSlider(
              controller: _controller,
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.red,
          ),
        ),
      ]),
    ));
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
