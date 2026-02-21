import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/model/tournament_model.dart';
import 'package:technical_task/utils/app_constant.dart';
import 'package:technical_task/utils/app_routes.dart';
import '../../common_widgets/app_custom_button.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/tournament_viewmodel.dart';
import '../../view_model/wallet_viewmodel.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.leaderboardScreen);
            },
          ),
          Consumer<AuthViewModel>(
            builder: (ctx, avm, child) {
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  avm.logout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: borderRadius(16.r),
                border: Border.all(color: Colors.black54),
              ),
              child: Row(
                children: [
                  Text(
                    "Wallet Balance",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),

                  Spacer(),

                  Consumer<WalletViewModel>(
                    builder: (ctx, wvm, child) {
                      return Text(
                        "₹${wvm.balance}",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      );
                    },
                  ),
                ],
              ),
            ),

            16.height,

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),

                Text(
                  "Tournament List",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                ).paddingSymmetric(horizontal: 16.w),

                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),

            14.height,

            Consumer2<TournamentViewModel, WalletViewModel>(
              builder: (ctx, tvm, wvm, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  itemBuilder: (context, index) {
                    final tournament = tvm.tournaments[index];
                    return _tournamentWidget(context, tournament, wvm, tvm);
                  },
                  separatorBuilder: (context, index) => 14.height,
                  itemCount: tvm.tournaments.length,
                );
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16.h, vertical: 16.h),
      ),
    );
  }

  Widget _tournamentWidget(BuildContext context, Tournament tournament, WalletViewModel wvm, TournamentViewModel tvm) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8, spreadRadius: 5)],
        borderRadius: borderRadius(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  tournament.name,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${tournament.entryFee}',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Entry Fee',
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),

          Divider(color: Colors.grey.shade300).marginSymmetric(vertical: 6.h),

          Row(
            children: [
              Expanded(
                child: Text(
                  "Prize Pool",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),

              Text(
                '₹${tournament.prizePool}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          Divider(color: Colors.grey.shade300).marginSymmetric(vertical: 6.h),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${tournament.availableSlots} / ${tournament.totalSlots}',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Available Slots',
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              Spacer(),

              AppCustomButton(
                verticalPadding: 8,
                horizontalPadding: 34,
                fontSize: 14,
                title: tournament.isJoined ? 'Joined' : 'Join',
                backgroundColor: tournament.isJoined ? Colors.grey.shade700 : Colors.blue,
                onTap: tournament.isJoined
                    ? () {
                        showToast("You have already joined this tournament.");
                      }
                    : () {
                        final error = tvm.joinTournament(tournament, wvm);
                        if (error != null) {
                          showToast(error);
                        }
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }

}