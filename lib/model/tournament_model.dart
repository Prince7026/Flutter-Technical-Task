class Tournament {
  final String id;
  final String name;
  final int entryFee;
  final int prizePool;
  final int totalSlots;
  int availableSlots;
  bool isJoined;

  Tournament({
    required this.id,
    required this.name,
    required this.entryFee,
    required this.prizePool,
    required this.totalSlots,
    required this.availableSlots,
    this.isJoined = false,
  });
}