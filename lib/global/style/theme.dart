import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/////////////////////////////// Fluttely Colors
const color1 = Color(0xFF02111A);

/////////////////////////////// Material Theme
ThemeData theme() {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Lato',
    canvasColor: color1,
    primaryColor: color1,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => states.contains(MaterialState.disabled)
              ? Colors.grey[700]
              : Colors.white,
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => Colors.transparent,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    ),
  );
}
