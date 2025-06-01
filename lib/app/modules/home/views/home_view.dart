import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qbussiness_card/app/global/appColors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 60.r,
            //   backgroundImage: AssetImage('assets/QC.png'), // Replace later
            // ),
            // SizedBox(height: 20.h),
            Center(
              child: Container(
                width: 350.w,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.r,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: AssetImage('assets/profile.jpg'), // Replace later
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Md. Mainul Islam',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Software Engineer, Information Technology',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white,),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Save Contact', style: TextStyle(fontSize: 14.sp)),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('Connect', style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialIcon(Icons.facebook),
                        socialIcon(Icons.link),
                        socialIcon(Icons.video_call),
                        socialIcon(Icons.mail),
                      ],
                    ),
                    // SizedBox(height: 20.h),
                    // Text(
                    //   'Founder & Managing Director, INTRO Card Ltd. Bangladesh’s 1st NFC Smart Business Card. '
                    //       'Professionally helping people grow their business network.',
                    //   style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoRow(Icons.email, 'md.mainul.islam@qcollection.com'),
                        SizedBox(height: 6.h),
                        infoRow(Icons.phone, '+8801521226758'),
                        SizedBox(height: 6.h),
                        infoRow(Icons.location_on, 'Concord IK Tower, Level 4 \nNorth Avenue, Gulshan 2, Dhaka-1212'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, size: 18.r, color: Color(AppColors.primaryColor)),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.white),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.white)),
      ],
    );
  }
}
