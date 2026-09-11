import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];

  final TextEditingController controller = TextEditingController();

  // ADD TASK
  void addTodo() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      todos.add(
        Todo(title: controller.text.trim()),
      );
    });

    controller.clear();
    Navigator.pop(context);
  }

  // DELETE TASK
  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  // COMPLETE TASK
  void toggleTodo(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }

  // ADD TASK BOTTOM SHEET
  void showAddTask() {
    controller.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom + 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Task ✨",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "What do you want to accomplish?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Enter your task...",
                  prefixIcon: const Icon(Icons.edit_outlined),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: addTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Add Task",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int completed = todos.where((todo) => todo.isCompleted).length;

    double progress = todos.isEmpty ? 0 : completed / todos.length;

    return Scaffold(
      backgroundColor: const Color(0xffF6F5FA),

      body: SafeArea(
        child: Column(
          children: [

            // ---------------- HEADER ----------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 25, 22, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff6C4AB6),
                    Color(0xff8E6CCB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "TaskFlow",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    todos.isEmpty
                        ? "Let's get things done 🚀"
                        : "Keep going, you're doing great! 🔥",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // PROGRESS CARD

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Row(
                      children: [

                        // Circular progress

                        SizedBox(
                          width: 65,
                          height: 65,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [

                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 6,
                                backgroundColor:
                                    Colors.white24,
                                valueColor:
                                    const AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),

                              Text(
                                "${(progress * 100).round()}%",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 18),

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              "$completed of ${todos.length} completed",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "Your daily progress",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- TASK TITLE ----------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                25,
                22,
                12,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "My Tasks",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "${todos.length} tasks",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- TASK LIST ----------------

            Expanded(
              child: todos.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.task_alt,
                            size: 80,
                            color: Colors.deepPurple,
                          ),

                          SizedBox(height: 15),

                          Text(
                            "No tasks yet!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 7),

                          Text(
                            "Tap + to create your first task",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )

                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),

                      itemCount: todos.length,

                      itemBuilder: (context, index) {

                        final todo = todos[index];

                        return Container(
                          margin:
                              const EdgeInsets.only(bottom: 12),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(.05),
                                blurRadius: 10,
                                offset:
                                    const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),

                            // CHECKBOX

                            leading: GestureDetector(
                              onTap: () =>
                                  toggleTodo(index),

                              child: Container(
                                width: 30,
                                height: 30,

                                decoration: BoxDecoration(
                                  color: todo.isCompleted
                                      ? Colors.deepPurple
                                      : Colors.transparent,

                                  border: Border.all(
                                    color: Colors.deepPurple,
                                    width: 2,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(9),
                                ),

                                child: todo.isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : null,
                              ),
                            ),

                            // TASK

                            title: Text(
                              todo.title,

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,

                                color: todo.isCompleted
                                    ? Colors.grey
                                    : Colors.black87,

                                decoration:
                                    todo.isCompleted
                                        ? TextDecoration
                                            .lineThrough
                                        : null,
                              ),
                            ),

                            // DELETE

                            trailing: IconButton(
                              onPressed: () =>
                                  deleteTodo(index),

                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ---------------- ADD BUTTON ----------------

      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddTask,

        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        icon: const Icon(Icons.add),

        label: const Text(
          "Add Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}