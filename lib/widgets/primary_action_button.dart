import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onTap,
    this.decoration,
    this.textStyle,
  }) : assert(
         (decoration == null && textStyle == null) ||
             (textStyle != null && decoration != null),
       );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white.withValues(alpha: 0.2),
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            decoration ??
            BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
        child: Center(
          child: Text(
            label,
            style:
                textStyle ??
                CustomStyles.bodyText1.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
