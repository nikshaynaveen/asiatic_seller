import 'package:asiatic_seller/const/const.dart';
import 'package:asiatic_seller/controllers/auth_controller.dart';
import 'package:asiatic_seller/views/home_screen/home.dart';
import 'package:asiatic_seller/views/widgets/loading_indicator.dart';
import 'package:asiatic_seller/views/widgets/our_button.dart';
import 'package:asiatic_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Authcontroller());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: uiGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  200.heightBox,
                  Image.asset(
                    icLogoNew,
                    width: 250,
                  ).box.make(),
                ],
              ),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isLoading.value
                          ? loadingIndicator()
                          : ourButton(
                              title: login,
                              color: uiGrey,
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: "Logged In");
                                    controller.isLoading(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                            ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              20.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
