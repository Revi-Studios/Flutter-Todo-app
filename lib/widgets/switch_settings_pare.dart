import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

typedef BoolVoidCallBack = void Function(bool newValue);

class SwitchSettingsPare extends StatefulWidget {
  final String title;
  final String? subTitle;
  final BoolVoidCallBack onChanged;
  final bool? isToggled;

  const SwitchSettingsPare({
    super.key,
    required this.title,
    required this.onChanged,
    this.subTitle,
    this.isToggled,
  });

  @override
  State<SwitchSettingsPare> createState() => _SwitchSettingsPareState();
}

class _SwitchSettingsPareState extends State<SwitchSettingsPare> {

  late bool isToggled;

  @override
  void initState() {
    isToggled = widget.isToggled ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
        thumbIcon: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Icon>{
          WidgetState.selected: Icon(Symbols.check),
          WidgetState.any: Icon(Symbols.close),
        }),

        value: isToggled,

        onChanged: (bool newValue) {
          setState(() {
            isToggled = newValue;
            widget.onChanged(newValue);
          });
        },
      ),

      title: Text(widget.title),

      subtitle: Text(widget.subTitle ?? ""),
    );
  }
}
