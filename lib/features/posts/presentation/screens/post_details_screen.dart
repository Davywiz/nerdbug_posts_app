import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';
import 'package:nerdbug_posts_app/features/posts/data/providers/posts_provider.dart';

class PostDetailsScreen extends ConsumerWidget {
  const PostDetailsScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePostIds = ref.watch(favoritePostIdsProvider);
    final isFavorite = favoritePostIds.contains(post.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${post.id}'),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(favoritePostIdsProvider.notifier).toggle(post.id),
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
          ),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: isFavorite
                              ? Theme.of(context).colorScheme.errorContainer
                              : Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            isFavorite ? 'Favorited' : 'Not favorited',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        post.body,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
