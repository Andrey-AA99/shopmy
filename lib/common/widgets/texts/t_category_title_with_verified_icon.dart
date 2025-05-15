import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/texts/t_category_title_text.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class TCategoryTitleWithVerifiedIcon extends StatelessWidget {
  const TCategoryTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines =1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TCategoryTitleText(
              title: title,
              color: textColor,
              maxLines: maxLines,
              textAlign:textAlign,
              brandTextSize: brandTextSize
          ),
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(Iconsax.verify, color: iconColor, size: TSizes.iconXs),
      ],
    );
  }
}