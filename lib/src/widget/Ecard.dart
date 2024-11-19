import 'package:flutter/material.dart';

class ECard extends StatelessWidget {
  const ECard({
    required this.child,
    this.alignment,
    this.onTap,
    this.borderRadius = 15,
    this.highlightColor = Colors.white24,
    this.cardColor = Colors.white,
    this.shadowColor = Colors.amber,
    this.elevation = 1,
    this.height,
    this.width,
    this.gradient,
    Key? key,
  }) : super(key: key);

  final Color highlightColor;
  final Color cardColor;
  final Color shadowColor;
  final double borderRadius;
  final double elevation;
  final double? height;
  final double? width;
  final Widget child;
  final VoidCallback? onTap;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      shadowColor: shadowColor,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradient,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            highlightColor: highlightColor,
            onTap: onTap,
            child: Container(
              alignment: alignment,
              height: height,
              width: width,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
