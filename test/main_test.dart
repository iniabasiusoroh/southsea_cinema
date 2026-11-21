import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  test('Android is supported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(isSupportedPlatform(), isTrue);
    debugDefaultTargetPlatformOverride = null;
  });

  // test('Other platforms are not supported', () {
  //   debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  //   expect(isSupportedPlatform(), isFalse);
  //   debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
  //   expect(isSupportedPlatform(), isFalse);
  //   debugDefaultTargetPlatformOverride = TargetPlatform.windows;
  //   expect(isSupportedPlatform(), isFalse);
  //   debugDefaultTargetPlatformOverride = TargetPlatform.linux;
  //   expect(isSupportedPlatform(), isFalse);
  //   debugDefaultTargetPlatformOverride = null;
  // });

  testWidgets('The unsupported platform screen explains what to do',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnsupportedPlatformApp());
    expect(find.textContaining('Android emulator'), findsOneWidget);
  });

  testWidgets('SouthseaCinemaApp restores the saved light theme', (
    WidgetTester tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefLightMode: true,
    });

    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final MaterialApp app = tester.widget<MaterialApp>(
      find.byType(MaterialApp),
    );
    expect(app.themeMode, ThemeMode.light);
  });

  testWidgets('Settings toggle applies and saves the light theme', (
    WidgetTester tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    tester
        .state<NavigatorState>(find.byType(Navigator).first)
        .pushNamed('/settings');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('light-mode-switch')));
    await tester.pumpAndSettle();

    final MaterialApp app = tester.widget<MaterialApp>(
      find.byType(MaterialApp),
    );
    expect(app.themeMode, ThemeMode.light);
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getBool(prefLightMode), isTrue);
  });
}
