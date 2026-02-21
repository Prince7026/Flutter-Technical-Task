import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../view_model/auth_viewmodel.dart';
import '../tournament_screen/tournament_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authVM = context.read<AuthViewModel>();

    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await authVM.tryAutoLogin();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => isLoggedIn ? const TournamentScreen() : LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text('Tournament List', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
            Spacer(),
            LoadingAnimationWidget.progressiveDots(color: Colors.black, size: 32.sp),
          ],
        ),
      ),
    );
  }

}