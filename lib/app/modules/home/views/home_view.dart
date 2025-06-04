import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qbussiness_card/app/modules/home/controllers/home_controller.dart';

import '../model/qcard model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Image.asset("assets/QC.png", height: 100.h, width: 100.w, fit: BoxFit.contain);
          }

          final data = controller.qCard.value;
          if (data == null) return const Text('No data found');

          return Padding(
            padding: EdgeInsets.all(_responsivePadding()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: _responsiveTopPadding()),
                  child: Image.asset(
                    'assets/QC.png',
                    height: _responsiveImageHeight(),
                    width: _responsiveImageWidth(),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: _responsiveSpacing()),
                Container(
                  height: _responsiveDividerHeight(),
                  width: 0.5.w,
                  color: Colors.black,
                ),
                SizedBox(width: _responsiveSpacing()),
                _buildProfileInfo(data),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileInfo(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.firstName ?? ''} ${data.lastName ?? ''}',
          style: TextStyle(
            fontSize: _responsiveTextSize(9),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.designation ?? '',
          style: TextStyle(fontSize: _responsiveTextSize(7)),
        ),
        SizedBox(height: 18.h), // 18 for BD; 8 for UK // 'Concord IK Tower, Level 4\nNorth Avenue, Gulshan 2, Dhaka-1212'
        _infoRow(Icons.location_on, data.officeAddress ?? ''),
        SizedBox(height: 2.h),
        _infoRow(Icons.email, data.email ?? ''),
        SizedBox(height: 2.h),
        _infoRow(Icons.phone, 'Mobile: ${data.phone ?? ''}'),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Text(text, style: TextStyle(fontSize: _responsiveTextSize(6)));
  }

  // Responsive helpers
  // Responsive image height
  double _responsiveImageHeight() {
    final width = ScreenUtil().screenWidth;
    if (width < 360) return 80.h;        // Small phones
    if (width < 420) return 90.h;        // Medium phones
    if (width < 600) return 100.h;       // Large phones
    if (width < 900) return 150.h;       // Small tablets
    return 200.h;                        // Large tablets
  }

// Responsive image width
  double _responsiveImageWidth() {
    final width = ScreenUtil().screenWidth;
    if (width < 360) return 60.w;
    if (width < 420) return 70.w;
    if (width < 600) return 75.w;
    if (width < 900) return 112.5.w;
    return 150.w;
  }

// Responsive spacing (e.g. between widgets)
  double _responsiveSpacing() {
    final width = ScreenUtil().screenWidth;
    if (width < 360) return 8.w;
    if (width < 420) return 10.w;
    if (width < 600) return 12.w;
    if (width < 900) return 15.w;
    return 20.w;
  }

// Responsive text size
  double _responsiveTextSize(double baseSize) {
    final width = ScreenUtil().screenWidth;
    if (width < 360) return baseSize.sp * 0.9;
    if (width < 420) return baseSize.sp;
    if (width < 600) return baseSize.sp * 1.1;
    if (width < 900) return baseSize.sp * 1.5;
    return baseSize.sp * 2.4;
  }

// Responsive padding
  double _responsivePadding() {
    final width = ScreenUtil().screenWidth;
    if (width < 320) return 8.r;   // Very small phones
    if (width < 375) return 10.r;  // iPhone SE, small Android
    if (width < 414) return 12.r;  // Standard phones
    if (width < 480) return 14.r;  // Large phones
    if (width < 600) return 16.r;  // Phablets
    if (width < 900) return 18.r;  // Tablets
    return 22.r;                   // Large screens
  }

  double _responsiveTopPadding() {
    final width = ScreenUtil().screenWidth;
    if (width < 320) return 8.h;   // Very small phones
    if (width < 375) return 10.h;  // iPhone SE, small Android
    if (width < 414) return 20.h;  // Standard phones
    if (width < 480) return 24.h;  // Large phones
    if (width < 600) return 28.h;  // Phablets
    if (width < 900) return 18.h;  // Tablets
    return 22.r;                   // Large screens
  }

// Responsive divider height
  double _responsiveDividerHeight() {
    final width = ScreenUtil().screenWidth;
    if (width < 320) return 60.h;  // Very old/small phones
    if (width < 375) return 70.h;  // iPhone SE, small Android
    if (width < 414) return 95.h;  // iPhone 12/13/14, standard phones
    if (width < 480) return 110.h;  // Large phones
    if (width < 600) return 130.h; // Phablets
    if (width < 900) return 150.h; // Tablets
    return 160.h;                  // Large tablets/desktop
  }
}
