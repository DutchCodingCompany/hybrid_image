import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HybridNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Map<String, String>? headers;
  final AlignmentGeometry alignment;

  HybridNetworkImage(
    this.imageUrl, {
    Key? key,
    this.width,
    this.height,
    this.headers,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  })  : assert(imageUrl.isNotEmpty),
        super(key: key);

  @override
  _HybridNetworkImageState createState() => _HybridNetworkImageState();
}

class _HybridNetworkImageState extends State<HybridNetworkImage> {
  late Uri uri;
  late String fileExtension;

  @override
  void initState() {
    uri = Uri.parse(widget.imageUrl);
    fileExtension = extension(
      uri.path.substring(
        uri.path.lastIndexOf('/') + 1,
        uri.path.length,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fileExtension == '.svg') {
      return SvgPicture.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        headers: widget.headers,
        alignment: widget.alignment,
      );
    }

    return Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      headers: widget.headers,
      alignment: widget.alignment,
    );
  }
}

class HybridAssetImage extends StatefulWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  HybridAssetImage(
    this.assetPath, {
    Key? key,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  })  : assert(assetPath.isNotEmpty),
        super(key: key);

  @override
  _HybridAssetImageState createState() => _HybridAssetImageState();
}

class _HybridAssetImageState extends State<HybridAssetImage> {
  late File file;
  late String fileExtension;

  @override
  void initState() {
    file = File(widget.assetPath);
    fileExtension = extension(basename(file.path));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fileExtension == '.svg') {
      return SvgPicture.asset(
        widget.assetPath,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }

    return Image.asset(
      widget.assetPath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }
}

class HybridFileImage extends StatefulWidget {
  final File file;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  HybridFileImage(
    this.file, {
    Key? key,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  })  : assert(file.existsSync()),
        super(key: key);

  @override
  _HybridFileImageState createState() => _HybridFileImageState();
}

class _HybridFileImageState extends State<HybridFileImage> {
  late String fileExtension;

  @override
  void initState() {
    fileExtension = extension(basename(widget.file.path));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fileExtension == '.svg') {
      return SvgPicture.file(
        widget.file,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }

    return Image.file(
      widget.file,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }
}
