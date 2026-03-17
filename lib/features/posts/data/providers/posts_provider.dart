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
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );
});

final postApiServiceProvider = Provider<PostApiService>((ref) {
  return PostApiService(ref.watch(dioProvider));
});

final postsProvider = FutureProvider<List<Post>>((ref) async {
  return ref.watch(postApiServiceProvider).fetchPosts();
});

class FavoritePostsNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => <int>{};

  void toggle(int postId) {
    final updatedFavorites = Set<int>.from(state);

    if (!updatedFavorites.add(postId)) {
      updatedFavorites.remove(postId);
    }

    state = updatedFavorites;
  }
}

final favoritePostIdsProvider =
    NotifierProvider<FavoritePostsNotifier, Set<int>>(
      FavoritePostsNotifier.new,
    );
