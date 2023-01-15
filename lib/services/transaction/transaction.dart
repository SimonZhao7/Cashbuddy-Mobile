class Transaction {
  final String userId;
  final String categoryId;
  final String title;
  final String details;
  final double amount;
  final DateTime dateTime;

  const Transaction({
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.details,
    required this.amount,
    required this.dateTime,
  });
}
