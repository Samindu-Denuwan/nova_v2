import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/style/color.dart';
import 'package:nova_v2/common/values/values.dart';
import 'package:nova_v2/common/widgets/app.dart';
import 'package:nova_v2/pages/home/widget/message_list.dart';

import '../home/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  AppBar _buildAppBar(){
      return transparentAppBar(
        title: Text("Messages",
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600
        ),)
      );

  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: _buildAppBar(),
      body: MessageList(),
    );
  }
}
