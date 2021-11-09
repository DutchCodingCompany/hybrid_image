import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Enum that decided which widget to show internally
enum HybridImageType {
  network,
  asset,
  file,
}

/// A widget that can display an image from a network, asset or file for both SVG and other image types.
/// it cannot be instantiated directly.
class HybridImage extends StatefulWidget {
  final File? file;
  final String? assetPath;
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Map<String, String>? headers;
  final AlignmentGeometry alignment;
  final HybridImageType type;

  /// Factory for [HybridImage] that returns a widget with a network image for both svg and other image types.
  /// [imageUrl] is the url of the image and is required.
  factory HybridImage.network({
    required String imageUrl,
    Key? key,
    Map<String, String>? headers,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      HybridImage._(
        key: key,
        type: HybridImageType.network,
        headers: headers,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        imageUrl: imageUrl,
      );

  /// Factory for [HybridImage] that returns a widget with an asset image for both svg and other image types.
  /// [assetPath] is the local path of the image and is required.
  factory HybridImage.asset({
    Key? key,
    required String assetPath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      HybridImage._(
        key: key,
        type: HybridImageType.asset,
        assetPath: assetPath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );

  /// Factory for [HybridImage] that returns a widget with a file image for both svg and other image types.
  /// [file] is required.
  factory HybridImage.file({
    Key? key,
    required File file,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      HybridImage._(
        key: key,
        type: HybridImageType.file,
        file: file,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );

  HybridImage._({
    Key? key,
    required this.type,
    this.imageUrl,
    this.file,
    this.assetPath,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    this.headers,
  })  : assert(type == HybridImageType.network ||
            type == HybridImageType.asset ||
            type == HybridImageType.file),
        assert(type == HybridImageType.network
            ? imageUrl != null && Uri.parse(imageUrl).isAbsolute
            : true),
        assert(type == HybridImageType.asset
            ? assetPath != null && assetPath.isNotEmpty
            : true),
        assert(type == HybridImageType.file ? file != null : true),
        super(key: key);

  @override
  _HybridImageState createState() => _HybridImageState();
}

class _HybridImageState extends State<HybridImage> {
  late Uri? uri;
  late String fileExtension;

  @override
  void initState() {
    if (widget.type == HybridImageType.network) {
      uri = Uri.parse(widget.imageUrl!);
      fileExtension = extension(uri!.pathSegments.last);
    }
    if (widget.type == HybridImageType.file) {
      fileExtension = extension(basename(widget.file!.path));
    }
    if (widget.type == HybridImageType.asset) {
      final file = File(widget.assetPath!);
      fileExtension = extension(basename(file.path));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case HybridImageType.network:
        if (fileExtension == '.svg') {
          return SvgPicture.network(
            widget.imageUrl!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            headers: widget.headers,
            alignment: widget.alignment,
          );
        }

        return Image.network(
          widget.imageUrl!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          headers: widget.headers,
          alignment: widget.alignment,
        );
      case HybridImageType.asset:
        if (fileExtension == '.svg') {
          return SvgPicture.asset(
            widget.assetPath!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }

        return Image.asset(
          widget.assetPath!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      case HybridImageType.file:
        if (fileExtension == '.svg') {
          return SvgPicture.file(
            widget.file!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }

        return Image.file(
          widget.file!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
    }
  }
}
