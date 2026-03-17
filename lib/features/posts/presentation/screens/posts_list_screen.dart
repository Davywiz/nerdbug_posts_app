import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';
import 'package:nerdbug_posts_app/features/posts/data/providers/posts_provider.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/screens/post_details_screen.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/widgets/post_list_item.dart';

class PostsListScreen extends ConsumerWidget {
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);
    final favoritePostIds = ref.watch(favoritePostIdsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(postsProvider.future),
          child: postsAsync.when(
            data: (posts) {
              if (posts.isEmpty) {
                return const _PostsEmptyState();
              }

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: posts.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PostListItem(
                        post: post,
                        isFavorite: favoritePostIds.contains(post.id),
                        onTap: () => _openPostDetails(context, post),
                        onFavoritePressed: () => ref
                            .read(favoritePostIdsProvider.notifier)
                            .toggle(post.id),
                      );
                    },
                  ),
                ),
              );
            },
            loading: () => const _PostsLoadingState(),
            error: (error, _) => _PostsErrorState(
              message: error.toString(),
              onRetry: () => ref.invalidate(postsProvider),
            ),
          ),
        ),
      ),
    );
  }

  void _openPostDetails(BuildContext context, Post post) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => PostDetailsScreen(post: post)),
    );
  }
}

class _PostsLoadingState extends StatelessWidget {
  const _PostsLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _PostsErrorState extends StatelessWidget {
  const _PostsErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 320),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        'Unable to load posts',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: onRetry,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PostsEmptyState extends StatelessWidget {
  const _PostsEmptyState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(
          height: 320,
          child: Center(child: Text('No posts available right now.')),
        ),
      ],
    );
  }
}
