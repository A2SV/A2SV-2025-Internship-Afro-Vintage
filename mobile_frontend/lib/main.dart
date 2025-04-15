import 'package:flutter/material.dart';
import 'package:mobile_frontend/features/consumer/presentation/pages/consumer_market_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080),
          brightness: Brightness.light,
        ).copyWith(
          secondary: const Color(0xFF006666),
          tertiary: const Color(0xFF00A3A3),
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFF008080),
              ); // selected label
            }
            return const TextStyle(color: Colors.grey);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: const Color(0xFF008080),
              ); // selected icon
            }
            return const IconThemeData(color: Colors.grey); // unselected icon
          }),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {'/': (context) => const ConsumerMarketPlace()},
    );
  }
}
