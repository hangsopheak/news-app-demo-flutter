import 'package:flutter/material.dart';

class OnboardingButtonWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double fontSize;
  final VoidCallback onPressed;

  const OnboardingButtonWidget({
    super.key,
    this.text = "Next",
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.fontSize = 14,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.colorScheme.primary,
        foregroundColor: textColor ?? theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: textStyle ??
            theme.textTheme.titleMedium?.copyWith(fontSize: fontSize),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: (textStyle ?? theme.textTheme.titleMedium)?.copyWith(
          color: textColor ?? theme.colorScheme.onPrimary,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
