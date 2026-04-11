import 'package:flutter/material.dart';

class BlobContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius? customBorderRadius;

  const BlobContainer({
    Key? key,
    required this.child,
    required this.color,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(24.0),
    this.customBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: customBorderRadius ??
            const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(40),
            ),
      ),
      child: child,
    );
  }
}
