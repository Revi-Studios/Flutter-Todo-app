import 'package:flutter/material.dart';

class TaskFilteringChips extends StatefulWidget {

  final TextEditingController controller;
  final VoidCallback onChange;

  const TaskFilteringChips({
    super.key,
    required this.controller,
    required this.onChange,
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
        FilterChip(label: Text("All"), onSelected: (value) => setState(() {if (!allSelection == true) {allSelection = value; widget.controller.text = "All"; widget.onChange();} doneSelection = false; pendingSelection = false;}), selected: allSelection, selectedColor: Theme.of(context).colorScheme.primary,),
    
        FilterChip(label: Text("Done"), onSelected: (value) => setState(() {if (!doneSelection == true) {doneSelection = value; widget.controller.text = "Done"; widget.onChange();} allSelection = false; pendingSelection = false;}), selected: doneSelection, selectedColor: Theme.of(context).colorScheme.primary,),
    
        FilterChip(label: Text("Pending"), onSelected: (value) => setState(() {if (!pendingSelection == true) {pendingSelection = value; widget.controller.text = "Pending"; widget.onChange();} doneSelection = false; allSelection = false;}), selected: pendingSelection, selectedColor: Theme.of(context).colorScheme.primary,),
    
      ],
    );
  }
}
