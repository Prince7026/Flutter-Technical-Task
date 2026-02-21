import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/model/leaderboard_player.dart';
import 'package:technical_task/shimmer_widgets/leaderboard_player_shimmer_widget.dart';
import '../../utils/app_constant.dart';
import '../../view_model/leaderboard_viewmodel.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  @override
  void initState() {
    super.initState();
    final vm = context.read<LeaderboardViewModel>();
    vm.fetchNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text('Leaderboard'),
      ),
      body: Consumer<LeaderboardViewModel>(
        builder: (context, vm, _) {
          if (vm.players.isEmpty && vm.isLoading) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: 10,
              itemBuilder: (_, __) => const LeaderboardPlayerShimmerWidget(),
              separatorBuilder: (_, __) => 16.height,
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                vm.fetchNextPage();
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async{
                vm.reset();
                vm.fetchNextPage();
              },
              backgroundColor: Colors.white,
              color: Colors.black,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: vm.players.length + (vm.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= vm.players.length) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.black, size: 24.sp)),
                    );
                  }
                  final player = vm.players[index];
                  return _playerWidget(context, player);
                },
                separatorBuilder: (context, index) => 16.height,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _playerWidget(BuildContext context, LeaderboardPlayer player) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8, spreadRadius: 5)],
        borderRadius: borderRadius(16.r),
      ),
      child: Row(
        children: [
          
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: borderRadius(100.r),
            ),
            child: Text(
              getInitials(player.name),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700
              ),
            ),
          ),

          14.width,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "Points : ${player.points} pts",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),

          Text(
            "Rank : ${player.rank}",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),
          ),
          
        ],
      ),
    );
  }

  String getInitials(String name) {
    if (name.trim().isEmpty) return "";
    List<String> parts = name.trim().split(" ").where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return "";
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    String first = parts.first[0].toUpperCase();
    String last = parts.last[0].toUpperCase();
    return "$first$last";
  }

}