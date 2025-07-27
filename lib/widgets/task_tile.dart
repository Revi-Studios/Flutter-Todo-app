import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:material_symbols_icons/symbols.dart';

// Task Tile
class TaskTile extends StatefulWidget {
  final String title;
  final String description;
  final bool checked;
  final VoidCallback updateMethod;

  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.checked,
    required this.updateMethod,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    final colorSheme = Theme.of(context).colorScheme;

    return Card(
      color: colorSheme.secondary,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(),
      ),

      child: ListTile(
        leading: Checkbox(
          value: checked,
          onChanged: (value) {
            setState(() {
              bool newCheckedValue = !checked;
              checked = newCheckedValue;
              userPrefrenceData.defaultTaskList[widget.title]["checked"] =
                  newCheckedValue;
              userPrefrenceData.saveData();
            });
          },
        ),

        title: Text(
          widget.title,
          style: TextStyle(
            decoration: checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: Text(
          widget.description,
          style: TextStyle(
            decoration: checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        trailing: IconButton(
          onPressed: () {
            setState(() {
              userPrefrenceData.defaultTaskList.remove(widget.title);
              userPrefrenceData.saveData();
              widget.updateMethod();
            });
          },
          icon: Icon(Symbols.delete, color: Colors.red),
        ),
      ),
    );
  }
}
