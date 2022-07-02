import 'package:pet_perfect_assignment/app/dio/dio.dart';
import 'package:pet_perfect_assignment/screen1/data/screen1_model.dart';

class Screen1API {
  const Screen1API({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<Screen1Model> fetchImage() async {
    final response = await _dio.get(ApiConst.image);
    return screen1ModelFromJson(jsonEncode(response.data));
  }
}
