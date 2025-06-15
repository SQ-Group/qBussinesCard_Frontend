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
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: imagePaddingTop(MediaQuery.sizeOf(context).width)), //30.h
                  child: Image.asset(
                    'assets/QC.png',
                    height: 100.h,
                    width: 75.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  height: verticalLineHeight(MediaQuery.sizeOf(context).width), //110.h,
                  width: 0.6.w,
                  color: Colors.black,
                ),
                SizedBox(width: 12.w),
                _buildProfileInfo(data),
              ],
            ),
          );
        }),
      ),
    );
  }

  double imagePaddingTop(double width) {
    if (width <= 320) {// Mobile S
      return 6.h;
    } else if (width <= 375) { // Mobile M
      return 8.h;
    } else if (width <= 475) { // Mobile L
      return 12.h;
    } else if (width <= 900) { // Tablet
      return 40.h;
    } else if(width <= 1366) { // Laptop
      return 10.h;
    } else {
      return 80.h;
    }
  }

  double verticalLineHeight(double width) {
    print("Screen width: $width");
    if (width <= 320) { // Mobile S
      return 80.h;
    } else if (width <= 375) { // Mobile M
      return 86.h;
    } else if (width <= 475) { // Mobile L
      return 90.h;
    } else if (width <= 900) { // Tablet
      return 130.h;
    } else if(width <= 1366) { // Laptop
      return 80.h;
    } else {
      return 200.h;
    }
  }


  Widget _buildProfileInfo(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.firstName ?? ''} ${data.lastName ?? ''}',
          style: TextStyle(
            fontSize: 9.sp, // Changed from 18.sp to 16.sp
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.designation ?? '',
          style: TextStyle(fontSize: 7.sp),
        ),
        SizedBox(height: 20.h),
        _infoRow(Icons.location_on, data.officeAddress ?? ''),
        _infoRow(Icons.email, data.email ?? ''),
        _infoRow(Icons.phone, 'Mobile: ${data.phone ?? ''}'),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 7.sp),
    );
  }
}
