//page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model.dart';
import 'provider.dart';

class ToDoPage extends ConsumerWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ToDo>> todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ToDos')),
      body: todos.when(
        data: (todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text('User ID: ${todo.userId}'),
                trailing: Checkbox(
                  value: todo.completed,
                  onChanged: null,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
