import 'package:flutter/material.dart';
import '../model/leaderboard_player.dart';

class LeaderboardViewModel extends ChangeNotifier {

  final List<LeaderboardPlayer> _players = [];
  bool isLoading = false;
  bool hasMore = true;
  int _page = 1;
  static const int _pageSize = 20;

  List<LeaderboardPlayer> get players => _players;

  Future<void> fetchNextPage() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final startRank = (_page - 1) * _pageSize + 1;

    final newPlayers = List.generate(_pageSize, (index) {
      final rank = startRank + index;
      return LeaderboardPlayer(
        rank: rank,
        name: 'Player $rank',
        points: 1000 - (rank * 5),
      );
    });

    _players.addAll(newPlayers);
    _page++;

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    _players.clear();
    _page = 1;
    hasMore = true;
    notifyListeners();
  }

}