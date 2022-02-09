import 'package:flutter/material.dart';
import 'package:nurulquran/models/course.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPlayer extends StatefulWidget {
  final Videos video;
  const CourseVideoPlayer({Key? key, required this.video}) : super(key: key);

  @override
  _CourseVideoPlayerState createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool init = false;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      widget.video.link,
    );

    _videoPlayerController.addListener(() {
      setState(() {});
    });

    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(_videoPlayerController))
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            "Loading Video... Please Wait",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white60),
                          ),
                        ),
                      ),
                    ),
              Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: VideoProgressIndicator(
                    _videoPlayerController,
                    allowScrubbing: false,
                    colors: const VideoProgressColors(
                        backgroundColor: Colors.grey,
                        bufferedColor: Colors.blueGrey,
                        playedColor: Colors.blueAccent),
                  ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Duration currentPosition =
                        _videoPlayerController.value.position;
                    Duration targetPosition =
                        currentPosition - const Duration(seconds: 10);
                    if (currentPosition > const Duration(seconds: 0)) {
                      _videoPlayerController.seekTo(targetPosition);
                    } else {
                      _videoPlayerController.seekTo(const Duration(seconds: 0));
                    }
                  },
                  icon: const Icon(Icons.fast_rewind_outlined)),
              const Padding(padding: EdgeInsets.all(2)),
              IconButton(
                iconSize: 70,
                onPressed: () {
                  _videoPlayerController.value.isPlaying
                      ? _videoPlayerController.pause()
                      : _videoPlayerController.play();
                },
                icon: _videoPlayerController.value.isPlaying
                    ? const Icon(Icons.pause_circle)
                    : const Icon(Icons.play_circle),
              ),
              IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Duration currentPosition =
                        _videoPlayerController.value.position;
                    Duration targetPosition =
                        currentPosition + const Duration(seconds: 10);
                    _videoPlayerController.seekTo(targetPosition);
                  },
                  icon: const Icon(Icons.fast_forward_outlined)),
            ],
          )
        ],
      ),
    );
  }
}
