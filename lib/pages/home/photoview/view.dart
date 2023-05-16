import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/values/colors.dart';
import 'package:photo_view/photo_view.dart';

import 'controller.dart';

class PhotoImageViewPage extends GetView<PhotoImageViewController> {
  const PhotoImageViewPage({Key? key}) : super(key: key);

  AppBar _buildAppBar (){
    return AppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primaryElement,
            height: 2.0,
          ),

      ),
      title: Text(
        "Photo View",
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: PhotoView(
            imageProvider: NetworkImage(controller.state.url.value)),
      ),
    );
  }
}
