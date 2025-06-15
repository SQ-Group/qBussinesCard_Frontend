import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qbussiness_card/app/modules/home/controllers/home_controller.dart';
import 'package:qbussiness_card/app/modules/home/views/home_view.dart';

void main() {
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getDesignSize(MediaQuery.sizeOf(context)),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Business Card',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: '/',
          getPages: [
            GetPage(
              name: '/',
              page: () => const HomeView(),
              binding: BindingsBuilder(() {
                Get.put(HomeController());
              }),
            ),
          ],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  Size getDesignSize(Size screenSize) {
    if (screenSize.width < 600) {
      return const Size(360, 640); // Mobile
    } else if (screenSize.width < 900) {
      return const Size(768, 1024); // Tablet
    } else {
      return const Size(1366, 768); // Desktop
    }
  }
}
