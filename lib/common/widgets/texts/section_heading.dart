import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    required this.title,
    this.buttonTitle = 'Все',
    this.showActionButton = true,
    this.onPressed,
  });

  final Color? textColor;
  final String title, buttonTitle;
  final bool showActionButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style:
            Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      if (showActionButton)
        TextButton(onPressed: onPressed, child: Text(buttonTitle))
    ]);
  }
}
