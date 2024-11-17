import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.callback,
    this.radius = 12,
    this.backgroundColor = const Color(0xFF3B82F6),
    this.borderColor,
    this.horizontalPadding = 16,
    this.verticalPadding = 8,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.image,
    this.icon,
  });

  final String title;
  final VoidCallback callback;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double? width;
  final double? height;
  final Color? textColor;
  final Widget? image;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      onTap: callback.call,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: 1,
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: width != null
              ? SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      if (image != null) image!,
                    ],
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: textColor,
                        size: 24,
                      ),
                    if (icon != null) const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
