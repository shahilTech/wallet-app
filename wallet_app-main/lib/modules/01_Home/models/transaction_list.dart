class TransactionList {
  final double amount;
  final String date;
  String? description;
  final String accountName;
  final String categoryName;
  final String type;

  TransactionList({
    required this.amount,
    required this.date,
    this.description,
    required this.accountName,
    required this.categoryName,
    required this.type,
  });

  static TransactionList fromMap(Map<String, Object?> map) {
    final amount = map['amount'] as double;
    final date = map['date'] as String;
    final description = map['description'] as String;
    final accountName = map['account_name'] as String;

    final categoryName = map['category_name'] as String;
    final type = map['type'] as String;

    return TransactionList(
        amount: amount,
        date: date,
        description: description,
        accountName: accountName,
        categoryName: categoryName,
        type: type);
  }
}
