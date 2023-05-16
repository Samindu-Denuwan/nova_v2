import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_v2/common/entities/user.dart';
import 'package:nova_v2/common/values/colors.dart';
import 'package:nova_v2/common/widgets/widgets.dart';

Widget HeadItem(UserLoginResponseEntity item){
  return Container(
      padding:  EdgeInsets.only(top: 30.w, left: 15.w, right: 15.w, bottom:15.w ),
      margin: EdgeInsets.only( bottom:30.w ),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow:const [
            BoxShadow(
                color: AppColors.tabCellSeparator,
                spreadRadius: 0,
                blurRadius: 15,
                offset:  Offset(0, 5)
            ),

          ],

      ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          SizedBox(
            height: 80.w,
            width: 80.w,
            child: netImageCached(item.photoUrl??"",
            width: 80.w,
            height: 80.w),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:  EdgeInsets.only( left: 15.w),
                child:Text(

                  item.displayName??"",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Poppins",
                    color: AppColors.thirdElement,
                    fontWeight: FontWeight.w500
                ),
                ) ,
              ),
              Container(
                margin:  EdgeInsets.only( left: 15.w, top: 5.w),
                child:Text(
                  "ID: ${item.accessToken??""}",style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: "Poppins",
                    color: AppColors.thirdElementText,
                    fontWeight: FontWeight.normal
                ),
                ) ,
              )
            ],
          ),

        ],
      ),

    ],
  ),
  );
}