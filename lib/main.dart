import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/utils/app_routes.dart';
import 'package:technical_task/view_model/auth_viewmodel.dart';
import 'package:technical_task/view_model/tournament_viewmodel.dart';
import 'package:technical_task/view_model/wallet_viewmodel.dart';

import 'view_model/leaderboard_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewModel()),
        ChangeNotifierProvider(create: (_) => TournamentViewModel()),
        ChangeNotifierProvider(create: (_) => LeaderboardViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: '',
          key: key,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        ),
      ),
    );
  }
}