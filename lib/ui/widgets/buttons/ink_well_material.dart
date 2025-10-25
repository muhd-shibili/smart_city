import 'package:flutter/material.dart';

// import '../../../utils/constants/theme_colors.dart';

class InkWellMaterial extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? color;
  final double? borderRadius;

  const InkWellMaterial({
    required this.onTap,
    required this.child,
    this.color,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
    color: color ?? Colors.white70,
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
      onTap: onTap,
      child: child,
    ),
  );
}