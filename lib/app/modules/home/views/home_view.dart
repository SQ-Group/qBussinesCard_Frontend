import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qbussiness_card/app/global/appColors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/QC.png', // Replace with your background image
                    fit: BoxFit.fill,
                    height: 150.h,
                    width: 75.w,
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    height: 210.h,
                    width: 1.w,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Md. Mainul Islam',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 8.sp, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Software Engineer',
                              style: TextStyle(fontStyle: FontStyle.normal),
                            ),
                            // Add more TextSpan if needed
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      infoRow(Icons.phone, '+8801521226758'),
                      SizedBox(height: 2.h),
                      infoRow(Icons.email, 'md.mainul.islam@qcollection.com'),
                      SizedBox(height: 2.h),
                      infoRow(Icons.location_on, 'Concord IK Tower, Level 4 \nNorth Avenue, Gulshan 2, Dhaka-1212'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 18.h), // Spacing between content and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save Contact',
                      style: TextStyle(fontSize: 8.sp, color: Color(AppColors.primaryColor)),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white), // optional border color
                    ),
                    child: Text(
                      'Connect',
                      style: TextStyle(fontSize: 8.sp, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, size: 18.r, color: Color(AppColors.primaryColor)),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20.r, color: Colors.black),
        SizedBox(width: 4.w),
        Text(text, style: TextStyle(fontSize: 6.sp, color: Colors.black)),
      ],
    );
  }
}
