import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopmy/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text);
    return ChoiceChip(
      label: isColor != null ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? TColors.white : null),
      avatar: isColor != null
          ? TCircularContainer(
              width: 50,
              height: 50,
              backgroundColor: THelperFunctions.getColor(text)!)
          : null,
      shape: isColor != null ? const CircleBorder() : null,
      labelPadding: isColor != null ? const EdgeInsets.all(0) : null,
      padding: isColor != null ? const EdgeInsets.all(0) : null,
      backgroundColor:
          isColor != null ? THelperFunctions.getColor(text)! : null,
    );
  }
}
