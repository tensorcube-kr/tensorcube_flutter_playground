import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller.dart';

class UpdateWidget extends ConsumerWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsyncValue = ref.watch(postNotifierProvider);
    final textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
      ),
      body: Center(
        child: postAsyncValue.when(
          data: (post) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Post ID: ${post.id}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Title: ${post.title}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Body: ${post.body}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Post ID',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final postId = int.tryParse(textEditingController.text);
                      if (postId != null && postId >= 1 && postId <= 100) {
                        ref
                            .read(postNotifierProvider.notifier)
                            .updatePost(postId);
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
        ),
      ),
    );
  }
}
