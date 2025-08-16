import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  /// Usally a [Text] widget goes here
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(top: 50, left: 20, bottom: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
