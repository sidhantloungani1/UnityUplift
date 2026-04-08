import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4350AF);
  static const Color secondaryColor = Colors.white;
}

const lightColorScheme = ColorScheme(
  primaryContainer: Colors.white,
  brightness: Brightness.light,
  primary: Color(0xFF4350AF), // primary 100
  onPrimary: Color(0xFF4350AF), // primary 700  BUTTON
  secondary: Color(0xffffffff), //primary 900
  onSecondary: Colors.white,
  background: Color(0xffffffff), // light bg
  onBackground: Colors.black, //black // TEXT COLORS
  surface: Color(0xff9098A3), // light grey,
  onSurface: Color(0xFF9D9D9D), // Subtitle colors
  surfaceVariant: Color(0xFFFFFDE7), // primary 50
  onSurfaceVariant: Color(0xFF4350AF), // button text color same in both modes
  error: Color(0xffff0000), // error
  onError: Color.fromARGB(255, 237, 233, 233),
  outline: Color(0xFFD7D6D1),
  scrim: Color(0xFF43A048),
  shadow: Color(0xFFACACAE),
);
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4350AF), // dark tone
  onPrimary: Color(0xFF4350AF), // primary 700  BUTTON & BUTTON BORDER
  secondary: Color(0xfff57f17), //primary 900
  onSecondary: Color(0xFF2E3642),
  background: Color(0xff121928), // background,
  onBackground: Colors.white, // TEXT COLORS
  surface: Colors.grey, // card color
  onSurface: Color(0xFFB7D6D1), // subtitle colors
  inverseSurface: Colors.white,
  onInverseSurface: Colors.black,
  onSurfaceVariant: Color(0xFF4350AF), // button text color same in both modes
  surfaceVariant: Color(0xFFFFFDE7),
  // onSurfaceVariant: Colors.white,
  outline: Colors.white,
  error: Color(0xffff0000), // error
  onError: Colors.white,
  scrim: Color(0xFF43A048),
  shadow: Color(0xFF41464E),
);

ThemeData theme({bool dark = false}) {
  return ThemeData(
    scaffoldBackgroundColor: dark ? Colors.black : Colors.white,
    // hintColor: Colors.deepBlack,
    useMaterial3: false,
    colorScheme: dark ? darkColorScheme : lightColorScheme,
    fontFamily: 'SFPro',
    appBarTheme: appBarTheme(dark),
    elevatedButtonTheme: elevatedButtonTheme(),
    // textButtonTheme: textButtonTheme(),
    // splashFactory: NoSplash.splashFactory,

    textTheme: dark ? Typography.whiteCupertino : Typography.blackCupertino,
    inputDecorationTheme: inputDecorationTheme(dark),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cardColor:
        dark ? const Color.fromRGBO(34, 34, 34, 1) : lightColorScheme.surface,
    chipTheme: ChipThemeData(
      // elevation: 0,
      // pressElevation: 0,
      selectedColor: Colors.transparent,
      backgroundColor: Color(0xFF4350AF),
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    disabledColor: Colors.grey,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return Colors.grey;
          return Colors.orange; // Use the component's default.
        },
      ),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      // elevation: MaterialStateProperty.resolveWith<double>((states) => 0.0),
      minimumSize: MaterialStateProperty.resolveWith<Size>(
        (states) => const Size(180, 40),
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (states) => const TextStyle(fontSize: 18),
      ),
      // splashFactory: NoSplash.splashFactory,
    ),
  );
}

TextButtonThemeData textButtonTheme() {
  return const TextButtonThemeData(
    style: ButtonStyle(splashFactory: NoSplash.splashFactory),
  );
}

final inputFieldBorderRadius = BorderRadius.circular(10.0);

final inputBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 3),
  borderRadius: inputFieldBorderRadius,
);

final inputFocusedBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.orange, width: 3),
  borderRadius: inputFieldBorderRadius,
);

final inputErrorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.red),
  borderRadius: inputFieldBorderRadius,
);

InputDecorationTheme inputDecorationTheme(bool dark) {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 4,
      color: dark ? Colors.grey : Colors.black,
    ),
    border: inputBorder,
    focusedBorder: inputFocusedBorder,
    errorBorder: inputErrorBorder,
    focusedErrorBorder: inputErrorBorder,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    // filled: true,
    // fillColor: dark ? Colors.grayVI : Colors.platinumWhiteI,
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}

AppBarTheme appBarTheme(bool dark) {
  return AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: dark ? Colors.white : Colors.grey),
    centerTitle: true,
    titleTextStyle: const TextStyle(color: Colors.orange),
  );
}
