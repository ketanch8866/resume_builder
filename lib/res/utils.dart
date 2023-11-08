import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/theam/app_colors.dart';

class Utils {
  static Future<bool> showDialoge({
    String? msg,
    String? title,
    bool? barrierDismissible,
    required Function onAccept,
  }) async {
    return await Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          title ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: Get.width * 0.2,
          child: CustomButton(
              title: "No",
              textColor: AppColors.primaryColor,
              buttonColors: const [
                AppColors.secondarybgColor,
                AppColors.primarybgColor,
              ],
              onPressed: () {
                Get.back(
                  result: false,
                );
              }),
        ),
        SizedBox(
          width: Get.width * 0.2,
          child: CustomButton(
              title: "Yes",
              textColor: AppColors.whiteColor,
              buttonColors: const [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ],
              onPressed: () {
                Get.back(
                  canPop: true,
                  result: true,
                );
                onAccept();
              }),
        ),
        const SizedBox(
          width: 8,
        )
      ],
    ));
  }

  static void showErrorDialoge(
      {required String msg,

      required String title}) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content:  Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal),
            // overflow: TextOverflow.ellipsis,
            // maxLines: 3,
          ),
      actions: [
        Center(
          child: SizedBox(
            width: Get.width * 0.3,
            child: CustomButton(
                title: "Ok",
                buttonColors: const [
                  AppColors.secondaryColor,
                  AppColors.primaryColor,
                ],
                onPressed: () {
                  Get.back();
                }),
          ),
        )
      ],
    ));
  }

  static void showSucessDialoge({
    required String msg,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset("assets/Lottie/Successful.json"),
              const SizedBox(
                height: 10,
              ),
              Text(
                msg,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.25,
                      child: CustomButton(
                          title: "Ok",
                          buttonColors: const [
                            AppColors.secondaryColor,
                            AppColors.primaryColor,
                          ],
                          onPressed: () {
                            Get.back(result: true,canPop: true);
                          }),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static void fieldFocusNodeChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showScanckBar({required String message,

    required ToastType toastType,IconData? iconData}){
Get.showSnackbar(GetSnackBar(
  duration:const Duration(seconds: 3),
  margin:const EdgeInsets.all(15),
snackStyle:SnackStyle.FLOATING ,
titleText: Text(toastType == ToastType.sucess
    ? "Congratulation"
    : toastType == ToastType.waring
    ? "Warning"
    : "Error",
style: AppTextStyle.normalTitleText.copyWith(color:  toastType == ToastType.sucess
    ? AppColors.greenColor
    : toastType == ToastType.waring
    ? AppColors.yellowColor
    : AppColors.redColor,),),
  messageText: Text(message,style:TextStyle(color:toastType == ToastType.sucess
      ? AppColors.greenColor
      : toastType == ToastType.waring
      ? AppColors.yellowColor
      : AppColors.redColor, ),),
  borderRadius: 15,
  backgroundColor: toastType == ToastType.sucess
      ? AppColors.greenbg
      : toastType == ToastType.waring
      ? AppColors.yellowbg
      : AppColors.redbg,
  borderColor: toastType == ToastType.sucess
      ? AppColors.greenColor
      : toastType == ToastType.waring
      ?  AppColors.yellowColor
      : AppColors.redColor,
  borderWidth: 2,
  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
  icon: Icon(
    iconData ?? Icons.error,
    size: 25,
    color: toastType == ToastType.sucess
        ? AppColors.greenColor
        : toastType == ToastType.waring
        ?  AppColors.yellowColor
        : AppColors.redColor,
  ),
));
  }
}
