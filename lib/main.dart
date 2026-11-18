import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/orders_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// need to run:
// flutter create --platforms=ios,macos

// For windows
// flutter create --platforms=windows .
// flutter pub add sqflite_common_ffi

bool isSupportedPlatform() {
  if (kIsWeb) {
    return false;
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return true;
  }
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return true;
  }
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    return true;
  }
  if (defaultTargetPlatform == TargetPlatform.windows) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    return true;
  }
  return false;
}

void main() {
  if (isSupportedPlatform()) {
    runApp(const SouthseaCinemaApp());
  } else {
    runApp(const UnsupportedPlatformApp());
  }
}

class UnsupportedPlatformApp extends StatelessWidget {
  const UnsupportedPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'This app is orders order with SQLite and is set up to run on '
              'Android only. Stop the app and run it on an Android emulator '
              'or device instead.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SouthseaCinemaApp extends StatelessWidget {
  const SouthseaCinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Southsea Cinema & Arts Centre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: cinemaBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cinemaBrand,
          primary: cinemaBrand,
          surface: cinemaSurface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: cinemaSurface,
          foregroundColor: cinemaBackground,
          iconTheme: IconThemeData(color: cinemaBrand),
          titleTextStyle: cinemaHeaderStyle,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomeView(),
        // '/listing': (context) => const MovieListing(),
        '/': (BuildContext context) {
          return const HomeView();
        },
        '/basket': (BuildContext context) {
          return const BasketView(); // Going to add Basket Screen.
        },
        '/settings': (BuildContext context) {
          return const SettingsScreen(); //Going to add Settings Screen.
        },
        '/orders': (BuildContext context) {
          return const OrdersView();
        }
      },
    );
  }
}

// Create a function that adds two integers
