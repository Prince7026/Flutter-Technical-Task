import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);

extension SpaceExtension on num {
  SizedBox get height => SizedBox(height: toDouble().h);

  SizedBox get width => SizedBox(width: toDouble().w);

  SizedBox get square => SizedBox.square(dimension: toDouble().w);
}

extension PaddingExtension on Widget {
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: this,
  );

  Widget paddingOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) => Padding(
    padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
}

extension MarginExtension on Widget {
  Widget marginAll(double value) => Container(margin: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({double vertical = 0, double horizontal = 0}) => Container(
    margin: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: this,
  );

  Widget marginOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) => Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
}

void showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}