import 'package:flutter/material.dart';

import 'widgets.dart';

class VideoCard extends StatelessWidget {
  const VideoCard(
      {Key? key,
      required this.title,
      required this.coverPicture,
      required this.videoUrl,
      required this.isPlay})
      : super(key: key);
  final String coverPicture;
  final String videoUrl;
  final String title;
  final bool isPlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: isPlay
              ? CustomVideoPlayer(videoUrl: videoUrl, play: isPlay)
              : Image.network(coverPicture,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
