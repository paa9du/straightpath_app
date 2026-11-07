import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:straight_path_app/shared/widgets/navigation/daily_tabs.dart';

void main() {
  testWidgets('daily action bar scrolls horizontally at narrow widths', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var selectedIndex = -1;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: DailyTabs(
              currentIndex: 0,
              onTap: (index) => selectedIndex = index,
            ),
          ),
        ),
      ),
    );

    final scrollable = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );
    expect(scrollable.scrollDirection, Axis.horizontal);

    await tester.scrollUntilVisible(
      find.text('Reflection'),
      120,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reflection'));
    expect(selectedIndex, 4);
  });

  testWidgets('active trailing action is revealed automatically', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SafeArea(child: DailyTabs(currentIndex: 4, onTap: _ignoreTap)),
        ),
      ),
    );
    await tester.pump();

    final reflectionBounds = tester.getRect(find.text('Reflection'));
    expect(reflectionBounds.left, greaterThanOrEqualTo(0));
    expect(reflectionBounds.right, lessThanOrEqualTo(320));
  });
}

void _ignoreTap(int _) {}
