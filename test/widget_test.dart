import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerdbug_posts_app/app.dart';

void main() {
  testWidgets('renders posts screen title', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NerdbugPostsApp()));

    expect(find.text('Posts'), findsOneWidget);
  });
}
