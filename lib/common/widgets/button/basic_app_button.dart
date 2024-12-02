import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title_button;
  final double ? height;
  final double ? width;
  const BasicAppButton({
    required this.title_button,
    required this.onPressed ,
    this.height,
    this.width,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(height ?? 80),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            )
          ),
          child: Text(title_button,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
              color: Colors.white
          ),)),
    );
  }
}
