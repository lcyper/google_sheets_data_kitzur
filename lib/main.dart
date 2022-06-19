import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sheets_data_kitzur/cubit/content_cubit.dart';
import 'package:google_sheets_data_kitzur/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentCubit(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Kitzur Tip',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.deepPurple,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: Colors.yellow.shade200,
            secondary: Colors.blue.shade300,
          ),
        ),
        home: const HomePage(),
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        locale: const Locale('es'),
        supportedLocales: const [
          Locale('es'),
        ],
      ),
    );
  }
}
