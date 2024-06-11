// page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model.dart';
import 'provider.dart';

class UserInputPage extends ConsumerStatefulWidget {
  const UserInputPage({super.key});

  @override
  ConsumerState<UserInputPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends ConsumerState<UserInputPage> {
  final TextEditingController _textController = TextEditingController();
  int? _currentPostId;

  @override
  Widget build(BuildContext context) {
    if (_currentPostId != null) {
      // provider의 상태 변화를 구독합니다.
      ref.listen<AsyncValue<Post>>(postProvider(id: _currentPostId!),
          // previous, next 모두 ToDo Class 입니다. (model.dart 참조)
          (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${next.error}')),
          );
        } else if (next.hasValue) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(next.value!.title),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(next.value!.body),
                  const SizedBox(height: 16),
                  Text('User Input Value: ${_currentPostId!}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('User Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter post ID',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final postId = int.tryParse(_textController.text);
                if (postId != null) {
                  setState(() {
                    _currentPostId = postId;
                  });
                }
              },
              child: const Text('Get Post'),
            ),
          ],
        ),
      ),
    );
  }
}
