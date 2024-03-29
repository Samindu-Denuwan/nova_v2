import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:dots_indicator/dots_indicator.dart';

import 'controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Scaffold(
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
                controller.changePage(index);
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
                          image: AssetImage("assets/images/banner2.png"))
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/banner3.png"))
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                          bottom: 80.h,
                          child: ElevatedButton(
                            onPressed: (){
                              controller.handleSignIn();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.white)
                                )
                            ),
                            child: Text("Login"),

                          )),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom:45.h,
                child: DotsIndicator(
                  position: controller.state.index.value.toInt(),
                  dotsCount: 3,
                  reversed: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                decorator: DotsDecorator(
                  size: Size.square(9),
                  activeSize: const Size(18,9),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                  
                ),)),
          ],
        ),
      )
      ,
    ));
  }
}
