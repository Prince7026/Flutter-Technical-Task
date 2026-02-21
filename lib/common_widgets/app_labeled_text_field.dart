import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_constant.dart';

class AppLabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTapOutside;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final double? width;

  const AppLabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.onChanged,
    this.validator,
    this.onTapOutside,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.readOnly = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h, bottom: 6.h),
      decoration: BoxDecoration(
        borderRadius: borderRadius(12.r),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),

          2.height,

          SizedBox(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              onChanged: onChanged,
              cursorHeight: 14.h,
              cursorColor: Colors.black,
              maxLength: maxLength,
              maxLines: maxLines,
              minLines: minLines,
              autofocus: false,
              readOnly: readOnly,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
                onTapOutside?.call();
              },
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: suffix,
                counterText: "",
              ),
            ),
          ),

        ],
      ),
    );
  }

}