import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qbussiness_card/app/global/appColors.dart';
import 'package:qbussiness_card/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/contactSaver.dart';
import '../model/qcard model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/QLogo.png",
              height: 60.h, width: 80.w, fit: BoxFit.contain
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0.h,
            left: 0.w,
            child: Image.asset(
              'assets/logoBg.png',
              height: MediaQuery.sizeOf(context).height / 2,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 80.h),
            child: InteractiveViewer(
              panEnabled: true, // Allow panning
              scaleEnabled: true, // Allow zooming
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Image.asset("assets/QC.png",
                        height: 100.h, width: 100.w, fit: BoxFit.contain);
                  }

                  final data = controller.qCard.value;
                  if (data == null) return const Text('No data found');

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: cardHeight(MediaQuery.sizeOf(context).width),
                        // width: cardWidth(MediaQuery.sizeOf(context).width),
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white, // Card background color
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Color(AppColors.primaryColor).withOpacity(0.5), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 4), // Shadow position (x, y)
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: imagePaddingTop(
                                      MediaQuery.sizeOf(context).width)),
                              child: Image.asset(
                                'assets/QC.png',
                                height: 900.h,
                                width: 90.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              height: verticalLineHeight(
                                  MediaQuery.sizeOf(context).width),
                              width: 0.6.w,
                              color: Colors.black,
                            ),
                            SizedBox(width: 12.w),
                            _buildProfileInfo(data),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: ElevatedButton(
                            onPressed: () async {
                              final contactSaver = ContactSaver();

                              // Check permission first
                              if (await contactSaver.hasContactsPermission()) {
                                // Permission already granted, save directly
                                await contactSaver.saveContact(
                                  data.phone ?? '',
                                  data.firstName ?? '',
                                  lastName: data.lastName,
                                );
                              } else {
                                // Request permission
                                final granted = await contactSaver.requestContactsPermission();
                                if (granted) {
                                  // Permission granted, now save
                                  await contactSaver.saveContact(
                                    data.phone ?? '',
                                    data.firstName ?? '',
                                    lastName: data.lastName,
                                  );
                                } else {
                                  // Permission denied, show option to open settings
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('Permission Required'),
                                      content: Text('Contacts permission is required to save contact. Would you like to open settings?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            contactSaver.openPermissionSettings();
                                          },
                                          child: Text('Open Settings'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(AppColors.primaryColor).withOpacity(0.8), // Background color
                              foregroundColor: Colors.white, // Text (foreground) color
                              minimumSize: Size(35.w, 30.h), // Responsive height and width
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              elevation: 4, // Optional shadow
                            ),
                            child: Text(
                              "Save Contact",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }


  double imagePaddingTop(double width) {
    if (width <= 320) {
      // Mobile S
      return 30.h;
    } else if (width <= 375) {
      // Mobile M
      return 34.h;
    } else if (width <= 425) {
      // Mobile L
      return 36.h;
    } else if (width <= 475) {
      // Mobile L
      return 44.h;
    } else if (width <= 900) {
      // Tablet
      return 30.h;
    } else if (width <= 1366) {
      // Laptop
      return 10.h;
    } else {
      return 80.h;
    }
  }

  double cardHeight(double width) {
    if (width <= 320) {
      // Mobile S
      return 120.h;
    } else if (width <= 375) {
      // Mobile M
      return 150.h;
    } else if (width <= 425) {
      // Mobile L
      return 160.h;
    } else if (width <= 475) {
      // Mobile L
      return 170.h;
    } else if (width <= 900) {
      // Tablet
      return 170.h;
    } else if (width <= 1366) {
      // Laptop
      return 120.h;
    } else {
      return 130.h;
    }
  }

  double cardWidth(double width) {
    if (width <= 320) {
      // Mobile S
      return 230.h;
    } else if (width <= 375) {
      // Mobile M
      return 260.h;
    } else if (width <= 475) {
      // Mobile L
      return 90.h;
    } else if (width <= 900) {
      // Tablet
      return 130.h;
    } else if (width <= 1366) {
      // Laptop
      return 80.h;
    } else {
      return 200.h;
    }
  }

  double verticalLineHeight(double width) {
    print("Screen width: $width");
    if (width <= 320) {
      // Mobile S
      return 90.h;
    } else if (width <= 375) {
      // Mobile M
      return 100.h;
    } else if (width <= 425) {
      // Mobile L
      return 112.h;
    } else if (width <= 475) {
      // Mobile L
      return 124.h;
    } else if (width <= 900) {
      // Tablet
      return 130.h;
    } else if (width <= 1366) {
      // Laptop
      return 80.h;
    } else {
      return 200.h;
    }
  }

  Widget _buildProfileInfo(Data data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.firstName ?? ''} ${data.lastName ?? ''}',
          style: TextStyle(
            fontSize: 11.sp, // Changed from 18.sp to 16.sp
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.designation ?? '',
          style: TextStyle(fontSize: 9.sp),
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
      style: TextStyle(fontSize: 9.sp),
    );
  }
}
