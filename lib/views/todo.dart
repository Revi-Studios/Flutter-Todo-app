
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/methods/task_saving.dart';
import 'package:material_symbols_icons/symbols.dart';


  final GlobalKey<_TaskListState> _taskListKey = GlobalKey<_TaskListState>();

  void taskListWidgetRebuild() {
    _taskListKey.currentState?.taskListWidgetRebuild();
  }

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text('App drawer')),

            ListTile(
              leading: Icon(Symbols.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),

      drawerEdgeDragWidth: 100,

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/task_creation'),
        child: Icon(Symbols.add),
      ),

      body: Column(
        children: [

          Flexible(child: TaskList(key: _taskListKey,)),

          Padding(padding: const EdgeInsets.only(top: 40), child: TextButton(onPressed: () {clearListDataFromStorage(taskListStorageKey); taskListWidgetRebuild();}, child: Text("Clear all")), ),

        ],
      ),
    );
  }
}

final String taskListStorageKey = "taskListData";

// Task List Data
List<dynamic> taskList = [
  {'title': 'Test Task', 'description': 'This is a test Task ', 'checked': false},
];

//Task List Widget
Future<Widget> createTaskListAndItems() async {
  taskList = await loadListFromStorage(taskListStorageKey);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: taskList.length,
    itemBuilder: (context, index) {      

      return TaskTile(
        title: taskList[index]['title'],
        description: taskList[index]['description'],
        checked: taskList[index]['checked'],
        index: index,
      );
    },
  );
}

class TaskList extends StatefulWidget {
  const TaskList({super.key, this.onRebuildRequest});

  final VoidCallback? onRebuildRequest;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  Future<Widget> taskListAndItemsFuture = createTaskListAndItems();

  void taskListWidgetRebuild() {
    setState(() {
      taskListAndItemsFuture = createTaskListAndItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: taskListAndItemsFuture,
      initialData: TaskTile(title: "initTile", description: "in", checked: true, index: 0,),

      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading the list, Error: ${snapshot.error.toString()}, date: ${DateTime.now().toString()}", style: TextStyle(color: Colors.red,)));
        } else {
          return Text("Something unexpected happened");
        }
      }
    );
  }
}


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
    return ListTile(
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

      subtitle: Text(widget.description, style: TextStyle(
          decoration: widget.checked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),),
    );
  }
}
