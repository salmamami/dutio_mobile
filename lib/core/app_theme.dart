import 'package:flutter/material.dart';

enum DutioRole { member, coordinator }

@immutable
class DutioPalette extends ThemeExtension<DutioPalette> {
  const DutioPalette({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.sage,
    required this.accent,
    required this.action,
    required this.strongAction,
    required this.secondaryText,
    required this.textPrimary,
    required this.textStrong,
    required this.onAccent,
    required this.blush,
    required this.border,
    required this.neutralSurface,
    required this.mutedSurface,
    required this.onMutedSurface,
    required this.heroSurface,
    required this.softSurface,
    required this.warmSurface,
    required this.onBlush,
    required this.inactiveSurface,
    required this.uploadSurface,
    required this.graySurface,
    required this.pointsInactiveSurface,
    required this.homeHeroBlush,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color sage;
  final Color accent;
  final Color action;
  final Color strongAction;
  final Color secondaryText;
  final Color textPrimary;
  final Color textStrong;
  final Color onAccent;
  final Color blush;
  final Color border;
  final Color neutralSurface;
  final Color mutedSurface;
  final Color onMutedSurface;
  final Color heroSurface;
  final Color softSurface;
  final Color warmSurface;
  final Color onBlush;
  final Color inactiveSurface;
  final Color uploadSurface;
  final Color graySurface;
  final Color pointsInactiveSurface;
  final Color homeHeroBlush;

  static const light = DutioPalette(
    background: AppTheme.cream,
    surface: AppTheme.white,
    surfaceVariant: AppTheme.lightGreen,
    sage: AppTheme.sage,
    accent: AppTheme.darkGreen,
    action: AppTheme.darkGreen,
    strongAction: AppTheme.ink,
    secondaryText: AppTheme.charcoal,
    textPrimary: AppTheme.dark,
    textStrong: AppTheme.ink,
    onAccent: AppTheme.white,
    blush: AppTheme.blush,
    border: AppTheme.lightGreen,
    neutralSurface: Color(0xFFD8D5C9),
    mutedSurface: AppTheme.charcoal,
    onMutedSurface: AppTheme.white,
    heroSurface: Color(0xFFE8EEDC),
    softSurface: Color(0xFFF1ECE4),
    warmSurface: Color(0xFFE9DCC0),
    onBlush: AppTheme.white,
    inactiveSurface: Color(0xFFF0EAE0),
    uploadSurface: Color(0xFFDCE3CB),
    graySurface: Color(0xFFB7B6AD),
    pointsInactiveSurface: Color(0xFFF1EADF),
    homeHeroBlush: Color(0xFFF2A2A2),
  );

  static const dark = DutioPalette(
    background: Color(0xFF151B17),
    surface: Color(0xFF202923),
    surfaceVariant: Color(0xFF29362F),
    sage: Color(0xFF536A57),
    accent: Color(0xFF9AC99F),
    action: Color(0xFF2D6340),
    strongAction: Color(0xFF2D6340),
    secondaryText: Color(0xFFB4BDB3),
    textPrimary: Color(0xFFE7ECE3),
    textStrong: Color(0xFFF4F1E6),
    onAccent: Color(0xFFFFFDF4),
    blush: Color(0xFFD98990),
    border: Color(0xFF415146),
    neutralSurface: Color(0xFF303A33),
    mutedSurface: Color(0xFF303A33),
    onMutedSurface: Color(0xFFE7ECE3),
    heroSurface: Color(0xFF29362F),
    softSurface: Color(0xFF29362F),
    warmSurface: Color(0xFF303A33),
    onBlush: Color(0xFF151B17),
    inactiveSurface: Color(0xFF29362F),
    uploadSurface: Color(0xFF29362F),
    graySurface: Color(0xFF29362F),
    pointsInactiveSurface: Color(0xFF29362F),
    homeHeroBlush: Color(0xFF9A5860),
  );

  static DutioPalette of(BuildContext context) =>
      Theme.of(context).extension<DutioPalette>()!;

  @override
  DutioPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? sage,
    Color? accent,
    Color? action,
    Color? strongAction,
    Color? secondaryText,
    Color? textPrimary,
    Color? textStrong,
    Color? onAccent,
    Color? blush,
    Color? border,
    Color? neutralSurface,
    Color? mutedSurface,
    Color? onMutedSurface,
    Color? heroSurface,
    Color? softSurface,
    Color? warmSurface,
    Color? onBlush,
    Color? inactiveSurface,
    Color? uploadSurface,
    Color? graySurface,
    Color? pointsInactiveSurface,
    Color? homeHeroBlush,
  }) => DutioPalette(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    sage: sage ?? this.sage,
    accent: accent ?? this.accent,
    action: action ?? this.action,
    strongAction: strongAction ?? this.strongAction,
    secondaryText: secondaryText ?? this.secondaryText,
    textPrimary: textPrimary ?? this.textPrimary,
    textStrong: textStrong ?? this.textStrong,
    onAccent: onAccent ?? this.onAccent,
    blush: blush ?? this.blush,
    border: border ?? this.border,
    neutralSurface: neutralSurface ?? this.neutralSurface,
    mutedSurface: mutedSurface ?? this.mutedSurface,
    onMutedSurface: onMutedSurface ?? this.onMutedSurface,
    heroSurface: heroSurface ?? this.heroSurface,
    softSurface: softSurface ?? this.softSurface,
    warmSurface: warmSurface ?? this.warmSurface,
    onBlush: onBlush ?? this.onBlush,
    inactiveSurface: inactiveSurface ?? this.inactiveSurface,
    uploadSurface: uploadSurface ?? this.uploadSurface,
    graySurface: graySurface ?? this.graySurface,
    pointsInactiveSurface: pointsInactiveSurface ?? this.pointsInactiveSurface,
    homeHeroBlush: homeHeroBlush ?? this.homeHeroBlush,
  );

  @override
  DutioPalette lerp(ThemeExtension<DutioPalette>? other, double t) {
    if (other is! DutioPalette) return this;
    return DutioPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      action: Color.lerp(action, other.action, t)!,
      strongAction: Color.lerp(strongAction, other.strongAction, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textStrong: Color.lerp(textStrong, other.textStrong, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      blush: Color.lerp(blush, other.blush, t)!,
      border: Color.lerp(border, other.border, t)!,
      neutralSurface: Color.lerp(neutralSurface, other.neutralSurface, t)!,
      mutedSurface: Color.lerp(mutedSurface, other.mutedSurface, t)!,
      onMutedSurface: Color.lerp(onMutedSurface, other.onMutedSurface, t)!,
      heroSurface: Color.lerp(heroSurface, other.heroSurface, t)!,
      softSurface: Color.lerp(softSurface, other.softSurface, t)!,
      warmSurface: Color.lerp(warmSurface, other.warmSurface, t)!,
      onBlush: Color.lerp(onBlush, other.onBlush, t)!,
      inactiveSurface: Color.lerp(inactiveSurface, other.inactiveSurface, t)!,
      uploadSurface: Color.lerp(uploadSurface, other.uploadSurface, t)!,
      graySurface: Color.lerp(graySurface, other.graySurface, t)!,
      pointsInactiveSurface: Color.lerp(
        pointsInactiveSurface,
        other.pointsInactiveSurface,
        t,
      )!,
      homeHeroBlush: Color.lerp(homeHeroBlush, other.homeHeroBlush, t)!,
    );
  }
}

class AppTheme {
  static const Color cream = Color(0xFFFFF8DE);
  static const Color sage = Color(0xFF84917D);
  static const Color darkGreen = Color(0xFF176B3A);
  static const Color lightGreen = Color(0xFFE7EBD9);
  static const Color charcoal = Color(0xFF7C7D78);
  static const Color blush = Color(0xFFEF9FA1);
  static const Color ink = Color(0xFF171914);
  static const Color dark = Color(0xFF30352D);
  static const Color white = Color(0xFFFFFDF4);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkGreen,
      primary: darkGreen,
      secondary: sage,
      surface: cream,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: cream,
      foregroundColor: dark,
      elevation: 0,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTheme.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    extensions: const [DutioPalette.light],
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DutioPalette.dark.background,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: DutioPalette.dark.action,
      primary: DutioPalette.dark.accent,
      onPrimary: DutioPalette.dark.background,
      secondary: DutioPalette.dark.sage,
      onSecondary: DutioPalette.dark.onAccent,
      surface: DutioPalette.dark.surface,
      onSurface: DutioPalette.dark.textPrimary,
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: DutioPalette.dark.background,
      foregroundColor: DutioPalette.dark.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: DutioPalette.dark.textPrimary,
      displayColor: DutioPalette.dark.textPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DutioPalette.dark.surfaceVariant,
      hintStyle: TextStyle(color: DutioPalette.dark.secondaryText),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? DutioPalette.dark.accent
            : DutioPalette.dark.secondaryText,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? DutioPalette.dark.action
            : DutioPalette.dark.surfaceVariant,
      ),
    ),
    extensions: const [DutioPalette.dark],
  );
}
