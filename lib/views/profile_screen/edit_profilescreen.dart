// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:asiatic_seller/const/const.dart';
import 'package:asiatic_seller/controllers/profile_controller.dart';
import 'package:asiatic_seller/views/widgets/custom_textfield.dart';
import 'package:asiatic_seller/views/widgets/loading_indicator.dart';
import 'package:asiatic_seller/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: uiGrey,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      //if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }

                      //if old pass matches

                      if (controller.snapshotData['password'] ==
                          controller.oldPassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldPassController.text,
                            newpassword: controller.newPassController.text);

                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newPassController.text);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldPassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Some error occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //if data image and controller path is empty
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(imgProduct, width: 80, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()

                  //if data is not empty but controller path is empty
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if controller path not empty but data image url is
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              // Image.asset(
              //   imgProduct,
              //   width: 150,
              // ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: normalText(text: changeImage, color: fontGrey)),
              10.heightBox,
              const Divider(color: white),
              customTextField(
                  label: name,
                  hint: "eg. NikApp",
                  controller: controller.nameController),
              30.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change password")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldPassController),
              10.heightBox,
              customTextField(
                  label: confirmPass,
                  hint: passwordHint,
                  controller: controller.newPassController),
            ],
          ),
        ),
      ),
    );
  }
}
