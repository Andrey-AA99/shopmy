import 'package:flutter/material.dart';
import 'package:shopmy/utils/constants/colors.dart';
import 'package:shopmy/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.isNetworkImage = false,
      this.borderRadius = TSizes.sm,
      this.backgroundColor = Colors.transparent,
      this.padding,
      this.fit = BoxFit.contain,
      this.applyImageRadius = true,
      this.onPressed,
      this.border});

  final double? width;
  final double? height;
  final String imageUrl;
  final bool isNetworkImage;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;
  final bool applyImageRadius;
  final VoidCallback? onPressed;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),

        ),
      ),
    );
  }
}
