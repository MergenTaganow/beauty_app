import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late VideoPlayerController _controller;
  bool paused = true;

  @override
  void initState() {
    super.initState();

    initPlayer();
  }

  initPlayer() {
    _controller = VideoPlayerController.asset(
      widget.videoUrl,
      // videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then((_) => setState(() {}))
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction < 0.5) {
          _controller.pause();
          setState(() {
            paused = !paused;
          });
        }
        // if (info.visibleFraction >= 0.5) {
        //   initPlayer();
        // } else if (info.visibleFraction < 0.5) {
        //   _controller.dispose();
        // }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: _controller.value.isInitialized
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    paused ? _controller.play() : _controller.pause();
                    setState(() {
                      paused = !paused;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      if (!_controller.value.isPlaying)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black.withOpacity(
                                0.5), // Darken the video when paused
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
