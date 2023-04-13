import 'package:flutter/material.dart';

class CenterNotchedShape extends CircularNotchedRectangle {
  final double notchRadius;

  CenterNotchedShape({this.notchRadius = 0.0});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final Path path = super.getOuterPath(host, guest);
    if (guest == null || guest.isEmpty) {
      return path;
    }
    final Rect rect =
        Rect.fromCircle(center: guest.center, radius: notchRadius);
    return path..addOval(rect);
  }
}
