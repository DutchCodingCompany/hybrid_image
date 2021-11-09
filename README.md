<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Hybrid Image

Wraps [flutter_svg](https://pub.dev/packages/flutter_svg) and the Flutter SDK image providers and picks the right widget based on the file extension

## Features

As of right now it's possible to use three widgets:
- `HybridAssetImage`
- `HybridNetworkImage`
- `HybridFileImage`

Memory image isn't supported as of right now, because it's not possible to distinct between svg images and regular images

## Getting started

Since it's a wrapper for flutter_svg and the normal image constructors, there's not special usage to be mentioned. Pick the right widget for your use case whether it's network, asset or file.

## Usage

```dart
final file = File('your/path.png');
HybridImage.file(
    file: file, 
    width: 50, 
    height: 50,
),
```

```dart
HybridImage.asset(
    assetPath: 'assets/my_image.svg', 
    width: 50, 
    height: 50,
),
```

```dart
HybridImage.network(
    imageUrl: 'https://my.website.com/this_image.jpg', 
    width: 50, 
    height: 50,
),
```

## Additional information

This package has been made for convenience, if you have any good additions feel free to open a pull request on Github :)
