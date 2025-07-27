import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/task_list_options_controller.dart';
import 'package:flutter_todo_app/widgets/task_list.dart';

class TaskFilteringChips extends StatefulWidget {
  final TaskListOptionsController controller;
  final VoidCallback onChanged;

  const TaskFilteringChips({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<TaskFilteringChips> createState() => _TaskFilterChipState();
}

class _TaskFilterChipState extends State<TaskFilteringChips> {
  bool allSelection = true;
  bool doneSelection = false;
  bool pendingSelection = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        FilterChip(
          label: Text("All"),
          onSelected: (value) => setState(() {
            if (!allSelection == true) {
              allSelection = value;
              widget.controller.value = TaskListOptions.all;
            }
            widget.onChanged();
            doneSelection = false;
            pendingSelection = false;
          }),
          selected: allSelection,
          selectedColor: Theme.of(context).colorScheme.primary,
        ),

        FilterChip(
          label: Text("Pending"),
          onSelected: (value) => setState(() {
            if (!pendingSelection == true) {
              pendingSelection = value;
              widget.controller.value = TaskListOptions.pending;
            }
            widget.onChanged();
            doneSelection = false;
            allSelection = false;
          }),
          selected: pendingSelection,
          selectedColor: Theme.of(context).colorScheme.primary,
        ),

        FilterChip(
          label: Text("Done"),
          onSelected: (value) => setState(() {
            if (!doneSelection == true) {
              doneSelection = value;
              widget.controller.value = TaskListOptions.done;
            }
            widget.onChanged();
            allSelection = false;
            pendingSelection = false;
          }),
          selected: doneSelection,
          selectedColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
