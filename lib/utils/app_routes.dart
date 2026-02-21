import 'package:flutter/material.dart';
import 'package:technical_task/view/init_screen/login_screen.dart';
import 'package:technical_task/view/init_screen/splash_screen.dart';
import '../view/leaderboard_screen/leaderboard_screen.dart';
import '../view/tournament_screen/tournament_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const tournamentScreen = '/tournamentScreen';
  static const leaderboardScreen = '/leaderboardScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case tournamentScreen:
        return MaterialPageRoute(builder: (_) => TournamentScreen());
      case leaderboardScreen:
        return MaterialPageRoute(builder: (_) => LeaderboardScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SplashScreen()));
    }
  }
}