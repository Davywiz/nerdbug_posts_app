import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';
import 'package:nerdbug_posts_app/features/posts/data/providers/posts_provider.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/screens/post_details_screen.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/widgets/post_list_item.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/widgets/posts_state_view.dart';

class PostsListScreen extends ConsumerWidget {
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);
    final favoritePostIds = ref.watch(favoritePostIdsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts'), centerTitle: false),
      body: SafeArea(
        child: RefreshIndicator(
          edgeOffset: 12,
          displacement: 28,
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
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: posts.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _PostsListHeader(
                          totalPosts: posts.length,
                          favoriteCount: favoritePostIds.length,
                        );
                      }

                      final post = posts[index - 1];
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
    return const PostsStateView(
      icon: Icons.article_outlined,
      title: 'Loading posts',
      message: 'Fetching the latest posts for you now.',
      action: Padding(
        padding: EdgeInsets.only(top: 4),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _PostsErrorState extends StatelessWidget {
  const _PostsErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return PostsStateView(
      icon: Icons.cloud_off_rounded,
      title: 'Unable to load posts',
      message:
          'Check your connection and try again. If the problem persists, the service may be temporarily unavailable.\n\n$message',
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: const Text('Try again'),
      ),
    );
  }
}

class _PostsEmptyState extends StatelessWidget {
  const _PostsEmptyState();

  @override
  Widget build(BuildContext context) {
    return const PostsStateView(
      icon: Icons.inbox_outlined,
      title: 'No posts yet',
      message:
          'There are currently no posts to display. Pull down to refresh and try again.',
    );
  }
}

class _PostsListHeader extends StatelessWidget {
  const _PostsListHeader({
    required this.totalPosts,
    required this.favoriteCount,
  });

  final int totalPosts;
  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primaryContainer, colorScheme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            'Browse community posts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Pull down anytime to refresh the list and tap the heart icon to keep track of favorites.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeaderChip(label: '$totalPosts posts'),
              _HeaderChip(label: '$favoriteCount favorites'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(label),
      ),
    );
  }
}
