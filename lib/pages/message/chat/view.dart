import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/values/colors.dart';
import 'package:nova_v2/common/widgets/toast.dart';
import 'package:nova_v2/pages/message/chat/widget/chat_list.dart';

import 'controller.dart';
import 'dart:math' as math;

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(){
    return AppBar(

      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 176, 106, 231),
            Color.fromARGB(255, 166, 112, 232),
            Color.fromARGB(255, 131, 123, 232),
            Color.fromARGB(255, 104, 132, 231),
          ],transform: GradientRotation(90)),
        ),

      ),
      title:Container(
        padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w ),
        child: Row(
          children: [
            Container(
        padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w ),
        child: Ink(
          child: SizedBox(
            width: 44.w,
            height: 44.w,
            child: CachedNetworkImage(
                imageUrl: controller.state.to_avatar.value,
              imageBuilder: (context, imageProvider) => Container(
                height: 44.w,
                width: 44.w,
                margin: null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(44.w)),
                  image: DecorationImage(image: imageProvider,fit: BoxFit.cover)

                ),
              ),
              errorWidget: (context, url, error) =>
                  const Image(image: AssetImage("assets/images/feature-1.png")) ,
            ),
          ),
        ),
            ),
            SizedBox(width: 15.w,),
            Container(
              width: 190.w,
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w ),
              child: Row(

                children: [
                  SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                      onTap: (){},
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(controller.state.to_name.value,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp
                          ),),
                          Text("unknown Location",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp
                            ),),

                        ],
                      ),
                    ),
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Gallery"),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("Camera"),
                    onTap: (){},
                  ),
                ],
              ));
        }
    );
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: _buildAppBar(),
      backgroundColor: Colors.grey.shade100,
      body:  SafeArea(
                  child: ConstrainedBox(
                    constraints:const BoxConstraints.expand() ,
                    child: Stack(
                      children: [
                        const ChatList(),
                        Positioned(
                            bottom: 0.h,
                            height: 60.h,
                            child: Container(
                              padding: EdgeInsets.only(left: 15.w, top: 5.w),
                              width: 360.w,
                              height: 60.h,
                              color: AppColors.primaryBackground,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  SizedBox(
                                    width: 225.w,
                                    height: 60.h,
                                    child: TextField(
                                      textInputAction:  TextInputAction.unspecified ,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      controller: controller.textController,
                                      autofocus: false,
                                      focusNode: controller.contentNode,
                                      decoration: const InputDecoration(
                                          hintText: "Message",
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )
                                          ),
                                          disabledBorder:  OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              )
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35.w,
                                    height: 35.w,
                                    child: Transform.rotate(
                                      angle: 330 *math.pi /180,
                                      child: IconButton(
                                        icon: const Icon(Icons.send_rounded,
                                          color: AppColors.primaryElement,
                                          size: 30,),
                                        onPressed: (){
                                          controller.sendMessage();
                                          Get.snackbar(" Message Delivered","Message Sent Successfuly!",
                                            icon: const Icon(Icons.message_rounded),
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 30.h,
                                    width: 30.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.w),
                                          color: AppColors.primaryElement,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade500,
                                                spreadRadius: 0,
                                                blurRadius: 1,
                                                offset: const Offset(0, 1)
                                            ),
                                          ]
                                      ),
                                    margin: const EdgeInsets.only( right: 15),
                                    child: GestureDetector(
                                      child: Icon(Icons.add,
                                        color: Colors.white,
                                        size:22.w,
                                      ),
                                      onTap: (){
                                        //send Images
                                        _showPicker(context);
                                        //controller.goMore();
                                      },
                                    ),

                                  ),


                                ],
                              ),


                            )),

                        // controller.state.more_status.value?  Positioned(
                        //     right: 15.w,
                        //     bottom: 70.h,
                        //     height: 100.h,
                        //     width: 40.w,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         GestureDetector(
                        //           child: Container(
                        //             height: 40.h,
                        //             width: 40.h,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(40.w),
                        //                 color: Colors.white,
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                       color: Colors.grey.shade200,
                        //                       spreadRadius: 2,
                        //                       blurRadius: 2,
                        //                       offset: const Offset(1, 1)
                        //                   ),
                        //                 ]
                        //             ),
                        //             child: Icon(Icons.camera_alt_outlined,size: 19.sp,
                        //               color: AppColors.primaryElement,),
                        //           ),
                        //           onTap: (){
                        //             toastInfo(msg: "Camera");
                        //           },
                        //         ),
                        //         GestureDetector(
                        //           child: Container(
                        //             height: 40.h,
                        //             width: 40.h,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(40.w),
                        //                 color: Colors.white,
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                       color: Colors.grey.shade200,
                        //                       spreadRadius: 2,
                        //                       blurRadius: 2,
                        //                       offset: const Offset(1, 1)
                        //                   ),
                        //                 ]
                        //             ),
                        //             child: Icon(Icons.photo_outlined,size: 19.sp,
                        //               color: AppColors.primaryElement,),
                        //           ),
                        //           onTap: (){
                        //             toastInfo(msg: "Gallery");
                        //           },
                        //         ),
                        //
                        //       ],
                        //     )):Container(),

                      ],

                    ),

                  )),
    );
  }
}
