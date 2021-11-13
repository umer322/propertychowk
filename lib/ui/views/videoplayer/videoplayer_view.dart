
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:propertychowk/ui/widgets/appprogress_indicatior.dart';
import 'package:video_player/video_player.dart';


class VideoViewer extends StatefulWidget {
  final String videoUrl;
  VideoViewer(this.videoUrl);
  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController _controller;
  ChewieController? chewieController;

  initializePlayer()async{
    _controller = VideoPlayerController.network(
        widget.videoUrl);
    await _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
    );
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child: chewieController!=null
              ? Chewie(
                controller: chewieController!,
              )
              : Container(child: Center(child: AppProgressIndication(),),),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    chewieController?.dispose();
  }
}
