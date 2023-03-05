import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../model/detailsProduct_model.dart';
import '../view/screen/order/fatora.dart';

class UiImagePainter extends CustomPainter {
  final ui.Image image;

  UiImagePainter(this.image);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // simple aspect fit for the image
    var hr = size.height / image.height;
    var wr = size.width / image.width;

    double ratio;
    double translateX;
    double translateY;
    if (hr < wr) {
      ratio = hr;
      translateX = (size.width - (ratio * image.width)) / 2;
      translateY = 0.0;
    } else {
      ratio = wr;
      translateX = 0.0;
      translateY = (size.height - (ratio * image.height)) / 2;
    }

    canvas.translate(translateX, translateY);
    canvas.scale(ratio, ratio);
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(UiImagePainter other) {
    return other.image != image;
  }
}

class UiImageDrawer extends StatelessWidget {
  final ui.Image? image;

  const UiImageDrawer({this.image});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: UiImagePainter(image!),
    );
  }
}

class Capturer extends StatefulWidget {
  static final Random random = Random();
  final Orders? map;
  final GlobalKey<OverRepaintBoundaryState>? overRepaintKey;

  Capturer({this.overRepaintKey, this.map});

  @override
  _CapturerState createState() => _CapturerState();
}

class _CapturerState extends State<Capturer> {
  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();
  ui.Image? image;
  ByteData? byteData;
  String? bs64;
  Uint8List? uint8List;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? UiImageDrawer(image: image)
        : Material(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: OverRepaintBoundary(
                        key: globalKey,
                        child: RepaintBoundary(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: List.generate(
                                3,
                                (i) => FatoraScreen(order: widget.map),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class OverRepaintBoundary extends StatefulWidget {
  final Widget? child;

  const OverRepaintBoundary({Key? key, this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
