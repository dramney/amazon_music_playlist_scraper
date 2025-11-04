import 'package:flutter/material.dart';

class AppTheme {
  // Визначаємо нашу кастомну палітру
  static const Color darkBlueBackground = Color(0xFF0A192F);
  static const Color darkBlueSurface = Color(0xFF1D2B45);
  static const Color lightBluePrimary = Color(0xFF4FC3F7);
  static const Color whiteText = Colors.white;
  static const Color whiteTextSecondary = Colors.white70;

  // Створюємо статичний getter для нашої темної теми
  static ThemeData get darkTheme {
    return ThemeData(
      // --- Основна тема ---
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBlueBackground,
      primaryColor: lightBluePrimary,
      fontFamily: 'Roboto', // Ви можете додати будь-який шрифт

      // --- Схема кольорів ---
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: lightBluePrimary, // Яскраво-блакитний для акцентів
        onPrimary: Colors.black, // Текст на кнопках
        secondary: darkBlueSurface, // Колір карток
        onSecondary: whiteText,
        error: Colors.redAccent,
        onError: Colors.black,
        background: darkBlueBackground, // Фон
        onBackground: whiteText,
        surface: darkBlueSurface, // Колір поверхонь (картки, поля вводу)
        onSurface: whiteText, // Текст на картках
      ),

      // --- Стиль AppBar ---
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBlueBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: whiteText,
        ),
      ),

      // --- Стиль полів вводу (TextField) ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkBlueSurface,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(color: whiteTextSecondary),
        labelStyle: const TextStyle(color: lightBluePrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBluePrimary, width: 2),
        ),
      ),

      // --- Стиль кнопок ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightBluePrimary, // Фон кнопки
          foregroundColor: Colors.black, // Колір тексту та іконки
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // --- Стиль Карток (Card) ---
      cardTheme: CardThemeData(
        elevation: 5,
        color: darkBlueSurface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // --- Стиль тексту ---
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: whiteText),
        bodyMedium: TextStyle(color: whiteTextSecondary),
        headlineSmall: TextStyle(
            color: whiteText, fontWeight: FontWeight.bold, fontSize: 24),
        titleLarge: TextStyle(
            color: whiteText, fontWeight: FontWeight.bold, fontSize: 20),
        titleMedium: TextStyle(
            color: whiteText, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}