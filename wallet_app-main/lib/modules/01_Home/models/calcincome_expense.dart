class Calc {
  final String date;
  final double amount;
  final String accountName;

  final String type;
  final double accountBalance;

  Calc({
    required this.date,
    required this.amount,
    required this.accountName,
    required this.type,
    required this.accountBalance,
  });

  static Calc fromMap(Map<String, Object?> map) {
    final date = map['date'] as String;

    final amount = map['amount'] as double;
    final accountName = map['account_name'] as String;

    final type = map['type'] as String;
    final balance = map['account_balance'] as double;

    return Calc(
        date: date,
        amount: amount,
        accountName: accountName,
        type: type,
        accountBalance: balance);
  }
}
