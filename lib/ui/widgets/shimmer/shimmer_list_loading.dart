import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListLoading extends StatefulWidget {

  final double height;
  final double width;

  const ShimmerListLoading({super.key, required this.height, required this.width});
  @override
  State<ShimmerListLoading> createState() => _ShimmerListLoadingState();
}

class _ShimmerListLoadingState extends State<ShimmerListLoading> {


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}