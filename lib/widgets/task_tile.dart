import 'package:flutter/material.dart';
import 'package:flutter_todo_app/consts/task_list.dart';
import 'package:flutter_todo_app/methods/task_related.dart';
import 'package:material_symbols_icons/symbols.dart';

// Task Tile
class TaskTile extends StatefulWidget {
  final String title;
  final String description;
  final bool checked;
  final VoidCallback updateMethod;
  final int index;

  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.checked,
    required this.updateMethod,
    required this.index,
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
              checked = !checked;
              switchCheckedState(widget.index, checked);
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
              taskList.remove(taskList[widget.index]);
              widget.updateMethod();
            });
          },
          icon: Icon(Symbols.delete, color: Colors.red,),
        ),
      ),
    );
  }
}
