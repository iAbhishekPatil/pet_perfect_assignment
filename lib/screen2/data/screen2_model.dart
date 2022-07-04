import 'dart:convert';

List<Screen2Model> screen2ModelFromJson(String str) => List<Screen2Model>.from(
      (json.decode(str) as List).map(Screen2Model.fromJson),
    );

String screen2ModelToJson(List<Screen2Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Screen2Model {
  Screen2Model({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
  factory Screen2Model.fromJson(dynamic json) {
    final jsonData = json as Map<String, dynamic>;
    return Screen2Model(
      userId: jsonData['userId'] as int,
      id: jsonData['id'] as int,
      title: jsonData['title'] as String,
      body: jsonData['body'] as String,
    );
  }

  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
