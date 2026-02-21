import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_constant.dart';

class LeaderboardPlayerShimmerWidget extends StatelessWidget {
  const LeaderboardPlayerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(16.r),
        ),
        child: Row(
          children: [
            // Avatar shimmer
            Container(
              height: 36.w,
              width: 36.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius(100.r),
              ),
            ),

            14.width,

            // Name + points shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14.h,
                    width: 120.w,
                    color: Colors.white,
                  ),
                  8.height,
                  Container(
                    height: 12.h,
                    width: 80.w,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Rank shimmer
            Container(
              height: 12.h,
              width: 50.w,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
