import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffb0175c),
      surfaceTint: Color(0xffb41b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd23674),
      onPrimaryContainer: Color(0xfffffbff),
      secondary: Color(0xff96435e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffd98b6),
      onSecondaryContainer: Color(0xff792c47),
      tertiary: Color(0xff9f3c00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc84d00),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f8),
      onSurface: Color(0xff25181b),
      onSurfaceVariant: Color(0xff584046),
      outline: Color(0xff8b7076),
      outlineVariant: Color(0xffdfbec5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2c30),
      inversePrimary: Color(0xffffb1c6),
      primaryFixed: Color(0xffffd9e1),
      onPrimaryFixed: Color(0xff3f001b),
      primaryFixedDim: Color(0xffffb1c6),
      onPrimaryFixedVariant: Color(0xff8e0046),
      secondaryFixed: Color(0xffffd9e1),
      onSecondaryFixed: Color(0xff3f001b),
      secondaryFixedDim: Color(0xffffb1c6),
      onSecondaryFixedVariant: Color(0xff782c47),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff360f00),
      tertiaryFixedDim: Color(0xffffb596),
      onTertiaryFixedVariant: Color(0xff7d2d00),
      surfaceDim: Color(0xffecd4d9),
      surfaceBright: Color(0xfffff8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f2),
      surfaceContainer: Color(0xffffe8ec),
      surfaceContainerHigh: Color(0xfffbe2e7),
      surfaceContainerHighest: Color(0xfff5dce1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff700036),
      surfaceTint: Color(0xffb41b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc82e6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff631b36),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa7516d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff612200),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbb4800),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f8),
      onSurface: Color(0xff1a0e11),
      onSurfaceVariant: Color(0xff463036),
      outline: Color(0xff654c52),
      outlineVariant: Color(0xff81666c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2c30),
      inversePrimary: Color(0xffffb1c6),
      primaryFixed: Color(0xffc82e6d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffa60a54),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa7516d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff8a3955),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffbb4800),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff943700),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8c1c5),
      surfaceBright: Color(0xfffff8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f2),
      surfaceContainer: Color(0xfffbe2e7),
      surfaceContainerHigh: Color(0xffefd7db),
      surfaceContainerHighest: Color(0xffe4ccd0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5d002c),
      surfaceTint: Color(0xffb41b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff930049),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff56102c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7b2e49),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff511b00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff812f00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3b262c),
      outlineVariant: Color(0xff5b4349),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2c30),
      inversePrimary: Color(0xffffb1c6),
      primaryFixed: Color(0xff930049),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff690032),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7b2e49),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5f1733),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff812f00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5c1f00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcab3b8),
      surfaceBright: Color(0xfffff8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffecef),
      surfaceContainer: Color(0xfff5dce1),
      surfaceContainerHigh: Color(0xffe7ced3),
      surfaceContainerHighest: Color(0xffd8c1c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb1c6),
      surfaceTint: Color(0xffffb1c6),
      onPrimary: Color(0xff650030),
      primaryContainer: Color(0xfff75490),
      onPrimaryContainer: Color(0xff490021),
      secondary: Color(0xffffb1c6),
      onSecondary: Color(0xff5c1530),
      secondaryContainer: Color(0xff7b2e49),
      onSecondaryContainer: Color(0xffff9bb8),
      tertiary: Color(0xffffb596),
      onTertiary: Color(0xff581e00),
      tertiaryContainer: Color(0xfff4630e),
      onTertiaryContainer: Color(0xff3f1300),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1c1013),
      onSurface: Color(0xfff5dce1),
      onSurfaceVariant: Color(0xffdfbec5),
      outline: Color(0xffa78990),
      outlineVariant: Color(0xff584046),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dce1),
      inversePrimary: Color(0xffb41b5e),
      primaryFixed: Color(0xffffd9e1),
      onPrimaryFixed: Color(0xff3f001b),
      primaryFixedDim: Color(0xffffb1c6),
      onPrimaryFixedVariant: Color(0xff8e0046),
      secondaryFixed: Color(0xffffd9e1),
      onSecondaryFixed: Color(0xff3f001b),
      secondaryFixedDim: Color(0xffffb1c6),
      onSecondaryFixedVariant: Color(0xff782c47),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff360f00),
      tertiaryFixedDim: Color(0xffffb596),
      onTertiaryFixedVariant: Color(0xff7d2d00),
      surfaceDim: Color(0xff1c1013),
      surfaceBright: Color(0xff453539),
      surfaceContainerLowest: Color(0xff170b0e),
      surfaceContainerLow: Color(0xff25181b),
      surfaceContainer: Color(0xff2a1c1f),
      surfaceContainerHigh: Color(0xff35262a),
      surfaceContainerHighest: Color(0xff403134),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd0db),
      surfaceTint: Color(0xffffb1c6),
      onPrimary: Color(0xff510025),
      primaryContainer: Color(0xfff75490),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd0db),
      onSecondary: Color(0xff4d0825),
      secondaryContainer: Color(0xffd27490),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd3c1),
      onTertiary: Color(0xff461600),
      tertiaryContainer: Color(0xfff4630e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1c1013),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff6d4db),
      outline: Color(0xffc9aab1),
      outlineVariant: Color(0xffa6898f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dce1),
      inversePrimary: Color(0xff910048),
      primaryFixed: Color(0xffffd9e1),
      onPrimaryFixed: Color(0xff2b0011),
      primaryFixedDim: Color(0xffffb1c6),
      onPrimaryFixedVariant: Color(0xff700036),
      secondaryFixed: Color(0xffffd9e1),
      onSecondaryFixed: Color(0xff2b0011),
      secondaryFixedDim: Color(0xffffb1c6),
      onSecondaryFixedVariant: Color(0xff631b36),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff250800),
      tertiaryFixedDim: Color(0xffffb596),
      onTertiaryFixedVariant: Color(0xff612200),
      surfaceDim: Color(0xff1c1013),
      surfaceBright: Color(0xff514044),
      surfaceContainerLowest: Color(0xff0f0507),
      surfaceContainerLow: Color(0xff271a1d),
      surfaceContainer: Color(0xff322428),
      surfaceContainerHigh: Color(0xff3e2f32),
      surfaceContainerHighest: Color(0xff4a393d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffebee),
      surfaceTint: Color(0xffffb1c6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffabc2),
      onPrimaryContainer: Color(0xff20000b),
      secondary: Color(0xffffebee),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffabc2),
      onSecondaryContainer: Color(0xff20000b),
      tertiary: Color(0xffffece5),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb08e),
      onTertiaryContainer: Color(0xff1b0500),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1c1013),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffebee),
      outlineVariant: Color(0xffdbbac1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dce1),
      inversePrimary: Color(0xff910048),
      primaryFixed: Color(0xffffd9e1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb1c6),
      onPrimaryFixedVariant: Color(0xff2b0011),
      secondaryFixed: Color(0xffffd9e1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb1c6),
      onSecondaryFixedVariant: Color(0xff2b0011),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb596),
      onTertiaryFixedVariant: Color(0xff250800),
      surfaceDim: Color(0xff1c1013),
      surfaceBright: Color(0xff5d4c50),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2a1c1f),
      surfaceContainer: Color(0xff3c2c30),
      surfaceContainerHigh: Color(0xff47373b),
      surfaceContainerHighest: Color(0xff534246),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
