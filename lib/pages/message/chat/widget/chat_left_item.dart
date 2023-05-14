import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/style/color.dart';
import 'package:nova_v2/common/values/values.dart';

Widget ChatLeftItem(Msgcontent item){
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 230.w,
              minHeight: 40.w
            ),
          child: Container(
            margin: EdgeInsets.only(right: 10.w, top: 0.w),
            padding: EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.w),
                  topLeft: Radius.circular(20.w),
              bottomRight: Radius.circular(20.w),
              bottomLeft: Radius.zero,),
            ),
            child: item.type == "text"? Text("${item.content}",style: const TextStyle(
              color: AppColor.primaryText,
              fontWeight: FontWeight.w400
            ),):
                ConstrainedBox(
                    constraints: BoxConstraints(
                    maxWidth: 90.w,

                ),
                  child: GestureDetector(
                    onTap: (){
                      
                    },
                    child: CachedNetworkImage(
                        imageUrl: "{$item.content}"),
                  ),
                )

          ),
        )
      ],

    ),
  );
}