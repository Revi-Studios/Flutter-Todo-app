
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
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
  // ["Walk with my dogs", DateTime.now().toIso8601String(), false,],
  // ["Make food", DateTime.now().toIso8601String(), false],
  // ["Play piano", DateTime.now().toIso8601String(), false],
  // ["Meet a friend", DateTime.now().toIso8601String() , false],
];



//Task List Widget
Future<Widget> createTaskListAndItems() async {
  List<dynamic> taskListFromStorage = await loadListFromStorage(taskListStorageKey);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: taskListFromStorage.length,
    itemBuilder: (context, index) {
      return TaskTile(
        title: taskListFromStorage[index][0],
        description: taskListFromStorage[index][1],
        checked: taskListFromStorage[index][2],
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
      initialData: TaskTile(title: "initTile", description: "in", checked: true),

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

  TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.checked,
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
