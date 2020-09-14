import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final UniqueKey newKey;
  final bool looping;

  Player({@required this.videoPlayerController, this.looping, this.newKey})
      : super(key: newKey);

  // : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  ChewieController _chewieController;

  disposeIt() {
    _chewieController.dispose();
  }

  @override
  void initState() {
    // print("inited");

    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16 / 9,
        autoInitialize: true, //first frame of the video
        looping: widget.looping,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    // print("disposed");
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

// class Test extends StatefulWidget {
//   _TestState z = new _TestState();
//   @override
//   _TestState createState() => _TestState();
//   // void ruunn() {
//   //   z.ar();
//   // }
// }

// class _TestState extends State<Test> {
//   int numm = 1;
//   ar() {
//     print("void a");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
