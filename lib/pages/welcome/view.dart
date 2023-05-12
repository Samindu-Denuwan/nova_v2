import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/pages/welcome/controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: 360.w,
        height: 780.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index){

              },
              controller: PageController(
                  initialPage: 0, keepPage: false, viewportFraction: 1
              ),
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/banner1.png"))
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/banner1.png"))
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/banner1.png"))
                  ),
                )
              ],
            ),
          ],
        ),
      )
      ,
    );
  }
}
