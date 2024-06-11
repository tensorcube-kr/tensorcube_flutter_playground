// model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart'; // 데이터 모델의 불변성 관련 기능 제공
part 'model.g.dart'; // JSON 직렬화/역직렬화 관련 기능 제공

@freezed
class ToDo with _$ToDo {
  factory ToDo({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _ToDo;

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);
}
