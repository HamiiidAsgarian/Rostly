// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:rostly/screens/videoFullScreen.dart';
// // import 'package:rostly/services/originalPlayer.dart';
// import 'package:rostly/widgets/originalPlayerWidgets.dart';
// import 'package:rostly/widgets/originalPlayerWidgets.dart';
// import 'package:video_player/video_player.dart';

// // class VideoPlayerApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Video Player Demo',
// //       home: VideoFullScreen(),
// //     );
// //   }
// // }

// class VideoFullScreen extends StatefulWidget {
//   final String url;
//   VideoFullScreen({this.url, Key key}) : super(key: key);
//   @override
//   _VideoFullScreenState createState() => _VideoFullScreenState();
// }

// class _VideoFullScreenState extends State<VideoFullScreen> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//   // double hourInseconds = 0;
//   // double minutesInSeconds = 0;
//   // double seconds = 0;
//   // double totalSeconds = 0;

//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);

//     // Create and store the VideoPlayerController. The VideoPlayerController
//     // offers several different constructors to play videos from assets, files,
//     // or the internet.
//     _controller = VideoPlayerController.network(
//       widget.url,
//     );
//     // Initialize the controller and store the Future for later use.
//     _initializeVideoPlayerFuture = _controller.initialize();
//     // Use the controller to loop the video.
//     _controller.setLooping(true);
//     // _controller.initialize();

//     setState(() {});

//     super.initState();
//   }

//   @override
//   void dispose() {
//     // Ensure disposing of the VideoPlayerController to free up resources.
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     _controller.dispose();
//     super.dispose();
//   }

//   // double volumeValue = 2;
//   bool videoOptionsVisibility = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Visibility(
//       // visible: ,
//       child: SizedBox(
//         // width: 200,
//         child: Stack(fit: StackFit.loose, children: [
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 print(videoOptionsVisibility);
//                 setState(() {
//                   videoOptionsVisibility = !videoOptionsVisibility;
//                 });
//                 print(videoOptionsVisibility);
//               },
//               child: PlayerScreen(
//                   initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
//                   controller: _controller),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Visibility(
//               visible: videoOptionsVisibility,
//               child: PlayerOptions(
//                   controller: _controller,
//                   function: () {
//                     setState(() {
//                       videoOptionsVisibility = !videoOptionsVisibility;
//                     });
//                   }),
//             ),
//           ),
//           Positioned.fill(
//             bottom: 0,
//             child: PlayerOptionsBar(controller: _controller),
//           ),
//         ]),
//       ),
//     ));
//   }
// }
// //////////////////**************************************////////////////////////// */

// class PlayerOptionsBar extends StatelessWidget {
//   const PlayerOptionsBar({
//     Key key,
//     @required VideoPlayerController controller,
//   })  : _controller = controller,
//         super(key: key);

//   final VideoPlayerController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           color: Colors.orange,
//           width: 50,
//           height: 50,
//           child: Icon(
//             Icons.play_arrow,
//             color: Colors.white,
//           ),
//         ),
//         Expanded(
//           flex: 5,
//           child: Container(
//             child: ProgressSlider(
//               controller: _controller,
//             ),
//             height: 50,
//             color: Colors.green.withOpacity(0.8),
//           ),
//         ),
//         Container(
//           color: Colors.amber,
//           width: 50,
//           height: 50,
//           child: GestureDetector(
//             onTap: () {
//               print(SystemChrome.restoreSystemUIOverlays());
//               Navigator.pop(context);
//               // Navigator.pushReplacement(
//               //     context,
//               //     MaterialPageRoute(
//               //         builder: (BuildContext context) =>
//               //             VideoPlayerScreen())); // SystemChrome.setPreferredOrientations([
//               // //   DeviceOrientation.landscapeRight,
//               // //   DeviceOrientation.landscapeLeft,
//               // // ]);
//             },
//             child: Icon(
//               Icons.fullscreen,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Container(
//           color: Colors.pink,
//           width: 50,
//           height: 50,
//           child: Icon(
//             Icons.loop,
//             color: Colors.white,
//           ),
//         ),
//         Container(
//           width: 50,
//           height: 180,
//           color: Colors.red.withOpacity(0.8),
//           child: Column(children: [
//             Expanded(
//               child: VolumeSlider(
//                 controller: _controller,
//               ),
//             ),
//             Container(
//               color: Colors.blue,
//               width: double.infinity,
//               height: 50,
//               child: Icon(
//                 Icons.volume_up,
//                 color: Colors.white,
//               ),
//             ),
//           ]),
//         ),
//       ],
//     );
//   }
// }

// //////////////////**************************************////////////////////////// */
// class PlayerScreen extends StatelessWidget {
//   const PlayerScreen({
//     Key key,
//     @required Future<void> initializeVideoPlayerFuture,
//     @required VideoPlayerController controller,
//   })  : _initializeVideoPlayerFuture = initializeVideoPlayerFuture,
//         _controller = controller,
//         super(key: key);

//   final Future<void> _initializeVideoPlayerFuture;
//   final VideoPlayerController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       child: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the VideoPlayerController has finished initialization, use
//             // the data it provides to limit the aspect ratio of the video.
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               // Use the VideoPlayer widget to display the video.
//               child: VideoPlayer(_controller),
//             );
//           } else {
//             // If the VideoPlayerController is still initializing, show a
//             // loading spinner.
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// ///////////////////*********************************************************//////////////////////////
