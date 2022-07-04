import 'package:pet_perfect_assignment/app/dio/dio.dart';
import 'package:pet_perfect_assignment/screen2/data/screen2_model.dart';

class Screen2API {
  const Screen2API({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<List<Screen2Model>> fetchPosts() async {
    final response = await _dio.get<String>(ApiConst.posts);
    return screen2ModelFromJson(response.data ?? '');
  }
}
