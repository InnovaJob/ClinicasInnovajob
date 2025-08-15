import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? extraActions;
  final bool showDrawerIcon;
  final VoidCallback? onDrawerPressed;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.extraActions,
    this.showDrawerIcon = true,
    this.onDrawerPressed,
    this.showBackButton = false,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 22),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : (isLargeScreen || !showDrawerIcon)
              ? null
              : Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, size: 22),
                    onPressed: onDrawerPressed ?? () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
      actions: [
        ...(extraActions ?? []),
        // Añadir un pequeño espacio al final
        const SizedBox(width: 8),
      ],
    );
  }
}
