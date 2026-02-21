import 'package:flutter/material.dart';
import '../model/tournament_model.dart';
import 'wallet_viewmodel.dart';

class TournamentViewModel extends ChangeNotifier {

  final List<Tournament> _tournaments = [
    Tournament(
      id: '1',
      name: 'Battle Royale Cup',
      entryFee: 100,
      prizePool: 1000,
      totalSlots: 10,
      availableSlots: 5,
    ),
    Tournament(
      id: '2',
      name: 'Pro League',
      entryFee: 200,
      prizePool: 3000,
      totalSlots: 20,
      availableSlots: 0,
    ),
    Tournament(
      id: '3',
      name: 'Rookie Tournament',
      entryFee: 50,
      prizePool: 500,
      totalSlots: 15,
      availableSlots: 10,
    ),
    Tournament(
      id: '4',
      name: 'Solo Showdown',
      entryFee: 75,
      prizePool: 800,
      totalSlots: 12,
      availableSlots: 3,
    ),
    Tournament(
      id: '5',
      name: 'Squad Clash',
      entryFee: 150,
      prizePool: 2000,
      totalSlots: 16,
      availableSlots: 8,
    ),
    Tournament(
      id: '6',
      name: 'Night Warriors',
      entryFee: 120,
      prizePool: 1500,
      totalSlots: 18,
      availableSlots: 1,
    ),
    Tournament(
      id: '7',
      name: 'Elite Arena',
      entryFee: 300,
      prizePool: 5000,
      totalSlots: 25,
      availableSlots: 20,
    ),
    Tournament(
      id: '8',
      name: 'Beginner Bash',
      entryFee: 30,
      prizePool: 300,
      totalSlots: 20,
      availableSlots: 15,
    ),
    Tournament(
      id: '9',
      name: 'Weekend Championship',
      entryFee: 250,
      prizePool: 4000,
      totalSlots: 22,
      availableSlots: 0,
    ),
    Tournament(
      id: '10',
      name: 'Legends League',
      entryFee: 500,
      prizePool: 10000,
      totalSlots: 30,
      availableSlots: 25,
    ),
  ];

  List<Tournament> get tournaments => _tournaments;

  String? joinTournament(
      Tournament tournament,
      WalletViewModel wallet,
      ) {
    if (tournament.isJoined) {
      return 'Already joined';
    }

    if (tournament.availableSlots == 0) {
      return 'Tournament Full';
    }

    if (!wallet.canJoin(tournament.entryFee)) {
      return 'Insufficient wallet balance';
    }

    wallet.deduct(tournament.entryFee);
    tournament.availableSlots--;
    tournament.isJoined = true;

    notifyListeners();
    return null; // success
  }

}