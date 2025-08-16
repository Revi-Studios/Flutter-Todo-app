import 'package:flutter/material.dart';

class SettingsPare extends StatelessWidget {
  final Icon? icon;
  final Widget title;
  final Widget? subtitle;
  final VoidCallback? onPressed;

  const SettingsPare({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.all(10.0), child: icon),
              VerticalDivider(
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                radius: BorderRadius.circular(5),
              ),
            ],
          ),
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }
}
