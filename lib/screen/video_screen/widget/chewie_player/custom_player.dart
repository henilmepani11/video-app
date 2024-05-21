import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'material_controls.dart';

class ChewieDemo extends StatefulWidget {
  final String? videoLink;
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
    this.videoLink,
    // required this.videoLink,
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4');
    await Future.wait([videoPlayerController!.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      looping: true,
      allowMuting: false,
      showOptions: false,
      autoPlay: true,
      customControls: const MaterialControls1(showPlayButton: true),
      materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.blue,
          playedColor: Colors.blue,
          handleColor: Colors.blue),
      autoInitialize: true,
    );
    setState(() {});
  }

  int currPlayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: chewieController != null &&
                    chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: chewieController!,
                  )
                : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
