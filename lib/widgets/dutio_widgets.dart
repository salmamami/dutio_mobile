import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class DutioLogo extends StatelessWidget {
  const DutioLogo({super.key, this.size = 38});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
  );
}

class DutioHeader extends StatelessWidget {
  const DutioHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.showLogo = true,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final bool showLogo;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(14, 8, 18, 10),
    decoration: BoxDecoration(
      color: DutioPalette.of(context).background,
      boxShadow: [
        BoxShadow(
          color: Color(0x18000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        if (showBack)
          IconButton(
            onPressed: onBack ?? () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: DutioPalette.of(context).textStrong,
            visualDensity: VisualDensity.compact,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: DutioPalette.of(context).accent,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (subtitle case final text?)
                Text(
                  text,
                  style: TextStyle(
                    color: DutioPalette.of(context).textPrimary,
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ),
        ?trailing,
        if (showLogo) const SizedBox(width: 8),
        if (showLogo) const DutioLogo(size: 32),
      ],
    ),
  );
}

class DutioBottomNav extends StatelessWidget {
  const DutioBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.coordinator = false,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool coordinator;

  @override
  Widget build(BuildContext context) {
    final items = coordinator
        ? const [
            (Icons.home_rounded, 'Home'),
            (Icons.chat_bubble_outline_rounded, 'Chat'),
            (Icons.person_outline_rounded, 'Profile'),
          ]
        : const [
            (Icons.home_rounded, 'Home'),
            (Icons.chat_bubble_outline_rounded, 'Chat'),
            (Icons.stars_rounded, 'Points'),
            (Icons.person_outline_rounded, 'Profile'),
          ];
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 4, 24, 12),
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: DutioPalette.of(context).neutralSurface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final active = selectedIndex == index;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onSelected(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.$1,
                    size: 26,
                    color: active
                        ? DutioPalette.of(context).textStrong
                        : DutioPalette.of(context).secondaryText,
                  ),
                  Text(
                    item.$2,
                    style: TextStyle(
                      fontSize: 9,
                      color: active
                          ? DutioPalette.of(context).accent
                          : DutioPalette.of(context).secondaryText,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DutioPanel extends StatelessWidget {
  const DutioPanel({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.radius = 20,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) => Material(
    color: color ?? DutioPalette.of(context).surface,
    elevation: 2,
    borderRadius: BorderRadius.circular(radius),
    clipBehavior: Clip.antiAlias,
    child: Padding(padding: padding, child: child),
  );
}

class DutioSectionTitle extends StatelessWidget {
  const DutioSectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: DutioPalette.of(context).textStrong,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      ?trailing,
    ],
  );
}

class DutioPrimaryButton extends StatelessWidget {
  const DutioPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.arrow_forward_rounded),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: DutioPalette.of(context).action,
        foregroundColor: DutioPalette.of(context).onAccent,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class DutioSettingTile extends StatelessWidget {
  const DutioSettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
    leading: Icon(icon, color: DutioPalette.of(context).accent, size: 24),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: subtitle == null ? null : Text(subtitle!),
    trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
  );
}
