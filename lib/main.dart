import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qbussiness_card/app/modules/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Business Card',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.loraTextTheme(
              Theme.of(context).textTheme,
            ),
          ),

          home: const HomeView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
