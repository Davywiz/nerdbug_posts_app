import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/app.dart';

void main() {
  runApp(const ProviderScope(child: NerdbugPostsApp()));
}
