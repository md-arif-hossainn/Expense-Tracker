import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125) ,
  );

void main() {
  runApp(
      MaterialApp(
       darkTheme: ThemeData.dark().copyWith(
         useMaterial3: true,
         colorScheme: kDarkColorScheme,

         cardTheme: const CardTheme().copyWith(
           color: kDarkColorScheme.onSecondary,
           margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
         ),

         elevatedButtonTheme: ElevatedButtonThemeData(
             style: ElevatedButton.styleFrom(
               backgroundColor: kDarkColorScheme.primaryContainer,
               foregroundColor: kDarkColorScheme.onPrimaryContainer
             )
         ),

         // textTheme: ThemeData().textTheme.copyWith(
         //     titleLarge: TextStyle(
         //         fontWeight: FontWeight.bold,
         //         color: kDarkColorScheme.onSecondaryContainer,
         //         fontSize: 16
         //     ),
         // ),
       ),
       theme: ThemeData()
           .copyWith(useMaterial3: true,
            colorScheme: kColorScheme,
         appBarTheme: const AppBarTheme().copyWith(
           backgroundColor: kColorScheme.onPrimaryContainer,
           foregroundColor: kColorScheme.onSecondary,
         ),
         cardTheme: const CardTheme().copyWith(
             color: kColorScheme.onSecondary,
             margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
         ),
         elevatedButtonTheme: ElevatedButtonThemeData(
             style: ElevatedButton.styleFrom(
               backgroundColor: kColorScheme.primaryContainer,
             )
          ),
         textTheme: ThemeData().textTheme.copyWith(
           titleLarge: TextStyle(
             fontWeight: FontWeight.bold,
             color: kColorScheme.onSecondaryContainer,
             fontSize: 16
           )
         ),

        ),
       themeMode: ThemeMode.system,
       home: const Expenses(),
     )
  );
}

// ThemeData.dark().copyWith( // dark() no longer takes any arguments
// useMaterial3: true,
// colorScheme: kColorScheme,
// cardTheme: ...
// )

