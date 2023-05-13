import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/values/colors.dart';
import 'package:nova_v2/common/widgets/toast.dart';

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




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: _buildAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: ConstrainedBox(
            constraints:const BoxConstraints.expand() ,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0.h,
                    height: 50.h,
                    child: Container(
                      padding: EdgeInsets.only(left: 15.w),
                      width: 360.w,
                      height: 60.h,
                      color: AppColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 220.w,
                            height: 60.h,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: controller.textController,
                              autofocus: false,
                              focusNode: controller.contentNode,
                              decoration: const InputDecoration(
                                hintText: "Message"
                              ),
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 30.w,
                            margin: EdgeInsets.only(left: 20.w),
                            child: GestureDetector(

                              child: Transform.rotate(
                                angle: 45 *math.pi /180,
                                child: Icon(Icons.attach_file_rounded,
                                  color: Colors.grey.shade500,
                                size:25.w,
                                ),
                              ),
                              onTap: (){
                                //send Images
                              },
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.only(left: 1.w, right: 10.w),
                            width: 35.w,
                            height: 35.w,
                            child: IconButton(
                              icon: const Icon(Icons.send_rounded,
                              color: Colors.purple,
                              size: 30,),
                              onPressed: (){
                                controller.sendMessage();
                                Get.snackbar(" Message Delivered","Message Sent Successfuly!", 
                                    icon: const Icon(Icons.message_rounded),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                    ))
              ],
            ),

          )),
    );
  }
}
