import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/values/colors.dart';
import 'package:nova_v2/common/widgets/app.dart';

import 'controller.dart';
import 'widgets/head_item.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

AppBar _buildAppBar(){
  return transparentAppBar(
    title: Text("My Profile",
      style: TextStyle(
        color: AppColors.primaryBackground,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),)
  );
}

Widget MeItem(MeListItem item){
  return Container(
    height: 56.w,
    color: AppColors.primaryBackground,
    margin: EdgeInsets.only(bottom: 1.w),
    padding:  EdgeInsets.only(top: 0.w, left: 15.w, right: 15.w),
    child: InkWell(
      onTap: (){
        if(item.route=="/logout"){
          Get.defaultDialog(
              title: "Are you sure to Logout ?",
              content: Container(),
              onConfirm: () {
                controller.onLogOut();
              },
              onCancel: () {},
              textConfirm: "Confirm",
              textCancel: "Cancel",
              confirmTextColor: Colors.white);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 56.w,
                child: Image(image: AssetImage(item.icon??""),
                width: 40.w,
                height: 40.w,),
              ),
              Container(
                margin:  EdgeInsets.only( left: 15.w),
                child:Text(
                  item.name??"",style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Poppins",
                  color: AppColors.thirdElement,
                  fontWeight: FontWeight.w500
                ),
                ) ,
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [

             Container(
               alignment: Alignment.center,
               child: Image(image: AssetImage("assets/icons/ang.png"),
               width: 15.w,
               height: 15.w,),
             ),
           ],
          ),
        ],
      ),
    ),
  );


}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => CustomScrollView(
        slivers: [
      SliverPadding(padding:  EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
      sliver: SliverToBoxAdapter(
        child: controller.state.head_detail.value == null
            ?Container()
            :HeadItem(controller.state.head_detail.value!),
      ),),
          SliverPadding(padding:  EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                var item = controller.state.meListItem[index];
                return MeItem(item);
              },
                childCount:  controller.state.meListItem.length
              ),
            ),
          ),
        
        ],
      )),
    );
  }
}
