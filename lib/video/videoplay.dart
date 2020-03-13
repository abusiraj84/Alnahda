import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chewie_list_item.dart';

class VideoPlay extends StatelessWidget {

  final int id;

  const VideoPlay(content, {Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: ListView(
        children: <Widget>[
          // ChewieListItem(
          //   videoPlayerController: VideoPlayerController.asset(
          //     'videos/IntroVideo.mp4',
          //   ),
          //   looping: true,
          // ),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
              
            ),
          ),
         
        ],
      ),
    );
  }
}
