import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model.dart';

part 'provider.g.dart';

@riverpod
Future<Post> post(PostRef ref, {required int id}) async {
  // get 요청을 보내고 응답을 받습니다.
  // 유저는 정수값을 입력합니다.
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

  // 응답 상태 코드를 확인합니다.
  if (response.statusCode == 200) {
    // 응답 바디를 JSON 형태로 디코딩합니다.
    final jsonData = json.decode(response.body);

    // JSON 데이터를 ToDo 객체 리스트로 변환합니다.
    final post = Post.fromJson(jsonData);

    return post;
  } else {
    // 에러 처리
    throw Exception('Failed to load post');
  }
}
