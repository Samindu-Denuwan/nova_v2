import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/routes/names.dart';
import 'package:nova_v2/pages/home/photoview/index.dart';
import 'package:get/get.dart';

Widget ChatRightItem(Msgcontent item){
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 230.w,
              minHeight: 40.w
            ),
          child: Container(
            margin: EdgeInsets.only(right: 10.w, top: 0.w),
              padding: EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w, bottom: 10.w),
            decoration:  BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 176, 106, 231),
                Color.fromARGB(255, 166, 112, 232),
                Color.fromARGB(255, 131, 123, 232),
                Color.fromARGB(255, 104, 132, 231),
              ],transform: GradientRotation(90)),
              borderRadius: BorderRadius.only(
                  topRight: Radius.zero,
                  topLeft: Radius.circular(20.w),
              bottomRight: Radius.circular(20.w),
              bottomLeft: Radius.circular(20.w),),
            ),
            child: item.type == "text"? Text("${item.content}",style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400
            ),):
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 150.w,


                ),
                  child: GestureDetector(
                    onTap: (){
                     Get.toNamed(AppRoutes.Photoimgview, parameters: {"url": item.content??""});
                    },
                    child: CachedNetworkImage(
                        imageUrl: "${item.content}"),
                  ),
                )

          ),
        )
      ],

    ),
  );
}