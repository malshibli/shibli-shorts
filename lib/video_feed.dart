import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoFeed extends StatefulWidget {
  final String videoUrl;
  const VideoFeed({super.key, required this.videoUrl});

  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Widget buildFeed() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("shorts").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
      var docs = snapshot.data!.docs;
      return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return VideoFeed(videoUrl: docs[index]["url"]);
        },
      );
    },
  );
}
