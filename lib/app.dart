import 'package:flutter/material.dart';
import 'package:nerdbug_posts_app/features/posts/presentation/screens/posts_list_screen.dart';

class NerdbugPostsApp extends StatelessWidget {
  const NerdbugPostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerdbug Posts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        useMaterial3: true,
      ),
      home: const PostsListScreen(),
    );
  }
}
