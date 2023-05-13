import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/values/values.dart';
import 'package:nova_v2/common/widgets/app.dart';
import 'package:nova_v2/pages/contact/widgets/contact_list.dart';

import 'controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(){
    return transparentAppBar(
      title: Text(
        "Contact",
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
          appBar: _buildAppBar(),
      body: const ContactList(),
    );
  }
}
