import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/values/values.dart';
import 'package:nova_v2/pages/contact/index.dart';
import 'package:nova_v2/pages/home/index.dart';
import 'package:nova_v2/pages/profile/index.dart';

import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  Widget _buildPageView(){
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
      children: const[
        MessagePage(),
        ContactPage(),
        ProfilePage()
      ],

    );
  }

  Widget _buildBottomNavigationBar(){
    return Obx(
            () => BottomNavigationBar(
                items: controller.bottomTabs,
            currentIndex: controller.state.page,
            type: BottomNavigationBarType.fixed,
            onTap: controller.handleNavBaraTap,
            showSelectedLabels: true,
            unselectedItemColor: AppColors.tabBarElement,
              selectedItemColor: AppColors.thirdElementText,

            ));
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),

    );
  }
}
