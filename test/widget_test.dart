import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/app.dart';
import 'package:nerdbug_posts_app/features/posts/data/models/post.dart';
import 'package:nerdbug_posts_app/features/posts/data/providers/posts_provider.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/screens/post_details_screen.dart';

void main() {
  testWidgets('renders posts screen title', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [postsProvider.overrideWith((ref) async => const <Post>[])],
        child: const NerdbugPostsApp(),
      ),
    );

    expect(find.text('Posts'), findsOneWidget);
  });

  testWidgets('renders full post details content', (tester) async {
    const post = Post(
      userId: 1,
      id: 7,
      title: 'Assessment title',
      body: 'Assessment body content',
    );

    await tester.pumpWidget(
      const MaterialApp(home: PostDetailsScreen(post: post)),
    );

    expect(find.text('Post #7'), findsOneWidget);
    expect(find.text('Assessment title'), findsOneWidget);
    expect(find.text('Assessment body content'), findsOneWidget);
  });
}
