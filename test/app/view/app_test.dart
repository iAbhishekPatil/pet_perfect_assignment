import 'package:flutter_test/flutter_test.dart';
import 'package:pet_perfect_assignment/app/app.dart';
import 'package:pet_perfect_assignment/screen1/view/screen1_page.dart';

void main() {
  group('App', () {
    testWidgets('renders Screen1Page', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Screen1Page), findsOneWidget);
    });
  });
}
