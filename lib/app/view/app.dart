import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_perfect_assignment/l10n/l10n.dart';
import 'package:pet_perfect_assignment/screen1/view/screen1_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 117, 58, 127)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color.fromARGB(255, 117, 58, 127),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 200, 255),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Screen1Page(),
    );
  }
}
