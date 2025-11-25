import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;

  const CustomAppBar({super.key, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      title: child ??
          Text(
            title ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
