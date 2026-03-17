import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';
import 'package:nerdbug_posts_app/features/posts/data/services/post_api_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
});

final postApiServiceProvider = Provider<PostApiService>((ref) {
  return PostApiService(ref.watch(dioProvider));
});

final postsProvider = FutureProvider<List<Post>>((ref) async {
  return ref.watch(postApiServiceProvider).fetchPosts();
});
