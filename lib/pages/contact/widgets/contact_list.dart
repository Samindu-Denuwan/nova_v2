import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/pages/contact/controller.dart';

import '../../../common/values/colors.dart';


class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);



  Widget BuildListItem(UserData item){

    return Container(
      margin: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w, bottom: 10.w),
      child: InkWell(
        onTap: (){
          if(item.id != null){
            controller.goChat(item);
          }

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.w),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1)
                      ),
                    ]
                ),
                width: 60.w,
                height: 60.w,
                child: CachedNetworkImage(
                  imageUrl: "${item.photourl}",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 60.w,
                    width: 60.w,
                    margin: null,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60.w)),
                        image: DecorationImage(image: imageProvider,fit: BoxFit.cover)

                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Image(image: AssetImage("assets/images/feature-1.png")) ,
                ),

              ),
            ),
            Container(
              width: 240.w,
              padding: EdgeInsets.only(top: 20.w, left: 0.w, right: 0.w, bottom: 0.w),
              decoration: const BoxDecoration(
                border: Border(
               bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Text(item.name?? "",
                    style: TextStyle(

                      fontWeight: FontWeight.w400,
                      color: AppColors.thirdElement,
                      fontSize: 16.sp
                    ),),
                  ),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
            () =>  CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index){
                          var item = controller.state.contactList[index];
                          return BuildListItem(item);
                        },
                        childCount: controller.state.contactList.length
                    ),
                  ),)
              ],
            ));
  }
}
