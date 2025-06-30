import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/task_related.dart';

// Task Tile
class TaskTile extends StatefulWidget {
  final String title;

  final String description;

  bool checked;

  final int index;

  TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.checked,
    required this.index,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
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
          value: widget.checked,
          onChanged: (value) {
            setState(() {
              widget.checked = !widget.checked;
              switchCheckedState(widget.index, widget.checked);
            });
          },
        ),
      
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: widget.checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      
        subtitle: Text(
          widget.description,
          style: TextStyle(
            decoration: widget.checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}