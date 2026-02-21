import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/common_widgets/app_labeled_text_field.dart';
import 'package:technical_task/utils/app_constant.dart';
import 'package:technical_task/utils/app_routes.dart';
import 'package:technical_task/view_model/auth_viewmodel.dart';
import '../../common_widgets/app_custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Login",
              style: TextStyle(fontSize: 28.sp, color: Colors.black, fontWeight: FontWeight.w600),
            ),

            4.height,

            Text(
              "Please Sign In to Continue",
              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
            ),

            16.height,

            AppLabeledTextField(
              controller: _userNameTextController,
              label: "Your Username",
              hintText: "Enter Your Username",
            ),

            16.height,

            AppLabeledTextField(controller: _emailTextController, label: "Your Email", hintText: "Enter Your Email"),

            16.height,

            AppLabeledTextField(
              controller: _passwordTextController,
              label: "Your Password",
              hintText: "Enter Your Password",
            ),

            Spacer(),

            Consumer<AuthViewModel>(
              builder: (ctx, avm, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (avm.error != null) ...[
                      Text(
                        avm.error!,
                        style: TextStyle(fontSize: 14.sp, color: Colors.red, fontWeight: FontWeight.w400),
                      ),

                      8.height,
                    ],
                    AppCustomButton(
                      title: 'Login',
                      isLoading: avm.isLoading,
                      onTap: () async {
                        if (avm.isLoading) {
                          return;
                        }
                        bool isAuth = await avm.login(
                          userName: _userNameTextController.value.text.trim(),
                          email: _emailTextController.value.text.trim(),
                          password: _passwordTextController.value.text.trim(),
                        );
                        print("isAuth :- ${isAuth.toString()}");
                        if (isAuth) {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.tournamentScreen);
                        }
                      },
                    ),
                  ],
                );
              },
            ),

          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
      ),
    );
  }
}