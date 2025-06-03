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
            return const CircularProgressIndicator();
          }

          final data = controller.qCard.value;
          if (data == null) return const Text('No data found');

          return Padding(
            padding: EdgeInsets.all(_responsivePadding()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/QC.png',
                  height: _responsiveImageHeight(),
                  width: _responsiveImageWidth(),
                  fit: BoxFit.contain,
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
        SizedBox(height: 18.h),
        _infoRow(Icons.location_on, 'Concord IK Tower, Level 4\nNorth Avenue, Gulshan 2, Dhaka-1212'),
        SizedBox(height: 2.h),
        _infoRow(Icons.email, data.email ?? ''),
        _infoRow(Icons.phone, 'Mobile: ${data.phone ?? ''}'),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Text(text, style: TextStyle(fontSize: _responsiveTextSize(6)));
  }

  // Responsive helpers
  double _responsiveImageHeight() {
    if (ScreenUtil().screenWidth < 600) return 100.h;
    if (ScreenUtil().screenWidth < 900) return 150.h;
    return 200.h;
  }

  double _responsiveImageWidth() {
    if (ScreenUtil().screenWidth < 600) return 75.w;
    if (ScreenUtil().screenWidth < 900) return 112.5.w;
    return 150.w;
  }

  double _responsiveTextSize(double baseSize) {
    if (ScreenUtil().screenWidth < 600) return baseSize.sp;
    if (ScreenUtil().screenWidth < 900) return baseSize.sp * 1.5;
    return baseSize.sp * 2.4;
  }

  double _responsiveDividerHeight() {
    if (ScreenUtil().screenWidth < 600) return 90.h;
    if (ScreenUtil().screenWidth < 900) return 130.h;
    return 160.h;
  }

  double _responsiveSpacing() {
    if (ScreenUtil().screenWidth < 600) return 10.w;
    if (ScreenUtil().screenWidth < 900) return 15.w;
    return 20.w;
  }

  double _responsivePadding() {
    if (ScreenUtil().screenWidth < 600) return 15.r;
    if (ScreenUtil().screenWidth < 900) return 15.r;
    return 20.r;
  }
}
