import 'package:flutter_test/flutter_test.dart';
import 'package:mapduo/app/app.dart';
import 'package:mapduo/app/view/home/home.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
