import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  const BackgroundGradient({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
      ),
      child: child,
    );
  }
}