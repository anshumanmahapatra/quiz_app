import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shape;

 const ShimmerWidget.rectangular(
      {Key? key, this.width = double.infinity, required this.height, required this.shape});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.grey.shade100,
        baseColor: Colors.grey.shade400,
        child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            shape: shape,
            color: Colors.black,
          ),
        ));
  }
}
