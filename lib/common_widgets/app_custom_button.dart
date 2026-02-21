import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppCustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double? height;
  final double? width;

  const AppCustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.backgroundColor = Colors.blue,
    this.horizontalPadding = 16,
    this.verticalPadding = 14,
    this.fontSize = 16,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null || isLoading;
    return Material(
      color: isDisabled ? Colors.grey : backgroundColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(16.r),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.black.withOpacity(0.05),
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding.h,
            horizontal: horizontalPadding.w,
          ),
          alignment: Alignment.center,
          child: isLoading
              ? LoadingAnimationWidget.progressiveDots(
            color: Colors.white,
            size: 24.sp,
          )
              : Text(
            title,
            style: TextStyle(
              fontSize: fontSize.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}