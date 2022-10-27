class AmountDetails {
  final double amount;
  final String accountName;
  final String type;

  AmountDetails(
      {required this.amount, required this.accountName, required this.type});

  static AmountDetails fromMap(Map<String, Object?> map) {
    final amount = map['amount'] as double;

    final accountName = map['account_name'] as String;

    final type = map['type'] as String;

    return AmountDetails(amount: amount, accountName: accountName, type: type);
  }
}
