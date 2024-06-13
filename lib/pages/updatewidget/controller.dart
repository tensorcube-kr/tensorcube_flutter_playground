import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model.dart';

part 'controller.g.dart';

// notifier 클래스를 생성합니다.
@riverpod
class PostNotifier extends _$PostNotifier {
  // all notifier must override the build method
  // 초기 상태를 반환하는 메서드입니다.
  // 이 메서드는 생성될 때 한 번 호출되며, 이후에는 state 속성을 통해 관리됩니다.
  @override
  Future<Post> build() async {
    // initial value
    int id = 1;
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    // check the status code
    if (response.statusCode == 200) {
      // decode the response body to JSON
      final jsonData = json.decode(response.body);
      // convert JSON data to Post object
      final post = Post.fromJson(jsonData);
      return post;
    } else {
      // error handling
      throw Exception('Failed to load post');
    }
  }

  // your methods here
  Future<void> updatePost(int id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    // check the status code
    if (response.statusCode == 200) {
      // decode the response body to JSON
      final jsonData = json.decode(response.body);

      // convert JSON data to Post object
      final updatedPost = Post.fromJson(jsonData);

      // update the state with the new post
      state = AsyncValue.data(updatedPost);
    } else {
      // error handling
      throw Exception('Failed to update post');
    }
  }
}
