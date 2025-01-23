import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Adapter{
  static width(num val) => val.w;
  static height(num val) => val.h;
  static fontSize(num val) => val.sp;
  static screenWidth() => 1.sw;
  static screenHeight() => 1.sh;
}