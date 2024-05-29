// ignore_for_file: use_build_context_synchronously

import 'package:asiatic_seller/const/colors.dart';
import 'package:asiatic_seller/const/const.dart';
import 'package:asiatic_seller/const/strings.dart';
import 'package:asiatic_seller/controllers/profile_controller.dart';
import 'package:asiatic_seller/views/widgets/custom_textfield.dart';
import 'package:asiatic_seller/views/widgets/loading_indicator.dart';
import 'package:asiatic_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: uiGrey,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopAddressController.text,
                        shopname: controller.shopNameController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdesc: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop updated");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  isDesc: true,
                  label: description,
                  hint: shopDescHint,
                  controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
