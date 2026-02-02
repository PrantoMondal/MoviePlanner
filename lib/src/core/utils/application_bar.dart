import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/constants/app_colors.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  const ApplicationBar({
    super.key,
    this.leading,
    this.appTitleText,
    this.actions,
    this.centerTitle = false,
    this.titleWidget,
    this.iconThemeData,
    this.titleTextStyle,
    this.bgColor, // optional override
    this.showDivider = false,
  });

  final Widget? leading;
  final String? appTitleText;
  final List<Widget>? actions;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconThemeData;
  final bool centerTitle;
  final Widget? titleWidget;
  final Color? bgColor; // optional background color override
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextStyle = titleTextStyle ?? theme.appBarTheme.titleTextStyle ?? theme.textTheme.headlineMedium;
    final effectiveIconTheme = iconThemeData ?? theme.appBarTheme.iconTheme ?? theme.iconTheme;
    final effectiveBgColor = bgColor ?? theme.appBarTheme.backgroundColor ?? AppColors.primary;

    return Column(
      children: [
        AppBar(
          toolbarHeight: showDivider ? kToolbarHeight - 1 : null,
          centerTitle: centerTitle,
          backgroundColor: effectiveBgColor,
          elevation: AppValues.elevationOne,
          leading: leading,
          iconTheme: effectiveIconTheme,
          title: appTitleText == null ? titleWidget : Text(appTitleText!, style: effectiveTextStyle),
          actions: actions,
        ),
        if (showDivider) const Divider(height: 1, color: AppColors.shadowColor),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
