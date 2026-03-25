import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offline_first_ecommerce/core/theme/app_colors.dart';
import 'package:offline_first_ecommerce/core/widgets/custom_button.dart';
import 'package:offline_first_ecommerce/core/widgets/custom_text.dart';
import 'package:offline_first_ecommerce/core/widgets/custom_textfield.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:offline_first_ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:offline_first_ecommerce/features/product/presentation/pages/product_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText("Welcome Back!", fontSize: 28, fontWeight: FontWeight.bold),
            SizedBox(height: 8.h),
            const CustomText("Sign in to continue your shopping", color: AppColors.greyDark),
            SizedBox(height: 40.h),
            
            CustomTextField(
              hintText: "Email Address",
              controller: emailController,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 20.h),
            
            CustomTextField(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
              prefixIcon: Icons.lock_outline,
            ),
            SizedBox(height: 40.h),
            
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  // Product page par bhejein
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProductPage()));
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: "Login",
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    context.read<AuthBloc>().add(LoginRequested(
                      emailController.text, 
                      passwordController.text
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}