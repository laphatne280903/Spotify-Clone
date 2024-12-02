import 'package:flutter/material.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';

class AppTheme{
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: "Satoshi",
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: Color(0xFF383838),
        fontWeight: FontWeight.w500,
      ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.4,
            )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.4,
          )
        )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontFamily: "Satoshi",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),

        )
      )
    )
  );

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      brightness: Brightness.dark,
      fontFamily: "Satoshi",
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: Color(0xFFA7A7A7),
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white,
                width: 0.4,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white,
                width: 0.4,
              )
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              textStyle: const TextStyle(
                fontFamily: "Satoshi",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),

              )
          )
      )
  );
}