import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model.dart';

// Necessary for code-generation
part 'provider.g.dart';

// Get 요청에 의해 가져온 데이터를 파싱하여 ToDo 객체로 변환합니다.
@riverpod
Future<List<ToDo>> todos(TodosRef ref) async {
  // get 요청을 보내고 응답을 받습니다.
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  // 응답 상태 코드를 확인합니다.
  if (response.statusCode == 200) {
    // 응답 바디를 JSON 형태로 디코딩합니다.
    final jsonData = json.decode(response.body);

    // JSON 데이터를 ToDo 객체 리스트로 변환합니다.
    final todos = (jsonData as List<dynamic>)
        .map((todoJson) => ToDo.fromJson(todoJson))
        .toList();

    return todos;
  } else {
    // 에러 처리
    throw Exception('Failed to load todos');
  }
}
