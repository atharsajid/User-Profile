
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final String? onErrorAsset;

  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.onErrorAsset,
  }) : super(key: key);

  @override
  State<CustomCachedNetworkImage> createState() => _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage> {
  bool lowQuality = false;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: widget.fit,
      width: double.maxFinite,
      progressIndicatorBuilder: (BuildContext context, String value, DownloadProgress progress) => Center(
                child: Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator(),
              ),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          Image.asset('assets/picture.png'),
    );
  }
}
