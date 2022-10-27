class TranscationModel {
  int? transactionid;
  final int categoryId;
  final int accountId;
  final int buyerId;
  final String date;
  final double amount;
  final String type;
  final String description;
  final String status;

  TranscationModel(
      {required this.date,
      required this.amount,
      required this.type,
      required this.description,
      required this.status,
      required this.accountId,
      required this.buyerId,
      required this.categoryId,
      this.transactionid});

  static TranscationModel fromMap(Map<String, Object?> map) {
    final id = map['transaction_id'] as int;
    final date = map['date'] as String;
    final amount = map['amount'] as double;
    final type = map['type'] as String;
    final description = map['description'] as String;
    final status = map['status'] as String;
    final accountId = map['account_id'] as int;
    final buyerId = map['buyer_id'] as int;
    final categoryId = map['category_id'] as int;

    return TranscationModel(
        transactionid: id,
        date: date,
        amount: amount,
        type: type,
        description: description,
        accountId: accountId,
        buyerId: buyerId,
        categoryId: categoryId,
        status: status);
  }
}
