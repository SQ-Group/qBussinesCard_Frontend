import 'package:contact_add/contact.dart';
import 'package:contact_add/contact_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qbussiness_card/app/global/appColors.dart';
import 'package:qbussiness_card/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/qcard model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Get.put(HomeController());
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Positioned(
          //   bottom: 0.h,
          //   left: 0.w,
          //   child: Image.asset(
          //     'assets/logoBg.png',
          //     color: Color(AppColors.primaryColor),
          //     height: (MediaQuery.sizeOf(context).height / 2) - 80.h,
          //     // width: (MediaQuery.sizeOf(context).width/2) + 20.w,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
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
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(AppColors.primaryColor)
                                  .withValues(alpha: 0.5),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
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
                                    MediaQuery.sizeOf(context).width),
                              ),
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
                              color: Color(AppColors.primaryColor),
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
                              if (kIsWeb) {
                                // For web platform, show a message that download is not available
                                // in this simplified version, or you can implement with url_launcher
                                Get.snackbar("Info", "vCard download feature is only available on mobile via contact saving");
                              } else {
                                // Mobile solution: Use contact_add plugin
                                try {
                                  final contact = Contact(
                                    firstname: data.firstName ?? '',
                                    lastname: data.lastName ?? '',
                                    phone: data.phone ?? '',
                                    company: data.company ?? '',
                                    email: data.email ?? '',
                                  );
                                  await ContactAdd.addContact(contact);
                                  Get.snackbar(
                                      "Success", "Contact saved successfully");
                                } catch (e) {
                                  Get.snackbar(
                                      "Error", "Failed to save contact: $e");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(AppColors.primaryColor),
                              foregroundColor: Colors.white,
                              minimumSize: Size(30.w, 30.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              "Save Contact",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
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
      return 36.h;
    } else if (width <= 375) {
      // Mobile M
      return 40.h;
    } else if (width <= 425) {
      // Mobile L
      return 44.h;
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
      return 124.h;
    } else if (width <= 375) {
      // Mobile M
      return 154.h;
    } else if (width <= 425) {
      // Mobile L
      return 164.h;
    } else if (width <= 475) {
      // Mobile L
      return 174.h;
    } else if (width <= 900) {
      // Tablet
      return 200.h;
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
      return 95.h;
    } else if (width <= 375) {
      // Mobile M
      return 110.h;
    } else if (width <= 425) {
      // Mobile L
      return 126.h;
    } else if (width <= 475) {
      // Mobile L
      return 150.h;
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
        GestureDetector(
          onTap: () async{
            if (data.linkedInLink != null && data.linkedInLink!.isNotEmpty) {
              final url = Uri.parse(data.linkedInLink!);
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              }
            }
          },
          child: Text(
            '${data.firstName ?? ''} ${data.lastName ?? ''}',
            style: TextStyle(
              fontSize: 11.sp, // Changed from 18.sp to 16.sp
              fontWeight: FontWeight.normal,
              color: Color(AppColors.primaryColor),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width * 0.5, // Adjust percentage as needed
          child: Text(
            [
              if (data.designation != null && data.designation!.isNotEmpty) data.designation,
              if (data.department != null && data.department!.isNotEmpty) data.department
            ].join(', '),
            style: TextStyle(
              fontSize: 9.sp,
              color: Color(AppColors.primaryColor),
            ),
          ),
        ),

        SizedBox(height: 10.h),
        _infoRow((){}, data.officeAddress ?? ''),
        _infoRow(() async {
          final email = data.email ?? '';
          if (email.isNotEmpty) {
            final uri = Uri(
              scheme: 'mailto',
              path: email,
            );
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        }, data.email ?? ''),
        _infoRow(() async {
          final Uri telUri = Uri(scheme: 'tel', path: data.phone ?? '');
          if (await canLaunchUrl(telUri)) {
            await launchUrl(telUri);
          } else {
            print('Could not launch dialer');
          }
        }, 'Mobile: ${data.phone ?? ''}'),

      ],
    );
  }

  Widget _infoRow(Function() onTap, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 9.sp, color: Color(AppColors.primaryColor)),
      ),
    );
  }
}
