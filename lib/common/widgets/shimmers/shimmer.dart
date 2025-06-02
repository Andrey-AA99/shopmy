import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopmy/utils/constants/colors.dart';

class TShimmerEffect extends StatelessWidget {
  const TShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xffededed),
        highlightColor: const Color(0xffb8b8b8),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color ?? TColors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
        ));
  }
}
