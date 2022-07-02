// To parse this JSON data, do
//
//     final screen1Model = screen1ModelFromJson(jsonString);

import 'dart:convert';

Screen1Model screen1ModelFromJson(String str) =>
    Screen1Model.fromJson(json.decode(str) as Map<String, dynamic>);

String screen1ModelToJson(Screen1Model data) => json.encode(data.toJson());

class Screen1Model {
  Screen1Model({
    required this.fileSizeBytes,
    required this.url,
  });
  factory Screen1Model.fromJson(Map<String, dynamic> json) => Screen1Model(
        fileSizeBytes: json['fileSizeBytes'] as int,
        url: json['url'] as String,
      );

  final int fileSizeBytes;
  final String url;

  Map<String, dynamic> toJson() => {
        'fileSizeBytes': fileSizeBytes,
        'url': url,
      };
}
