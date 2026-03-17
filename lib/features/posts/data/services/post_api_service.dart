import 'package:dio/dio.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';

class PostApiService {
  const PostApiService(this._dio);

  final Dio _dio;

  Future<List<Post>> fetchPosts() async {
    final response = await _dio.get<List<dynamic>>('/posts');

    final data = response.data;
    if (data == null) {
      throw const FormatException('No posts were returned from the API.');
    }

    return data
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
