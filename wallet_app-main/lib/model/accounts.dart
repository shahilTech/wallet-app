class AccountModel {
  int? accountId;
  final String accountName;
  final double balance;
  double monthlyIncome;
  double monthlyExpesne;

  AccountModel({
    required this.monthlyIncome,
    required this.monthlyExpesne,
    required this.accountName,
    required this.balance,
    this.accountId,
  });

  static AccountModel fromMap(Map<String, Object?> map) {
    final id = map['account_id'] as int;
    final name = map['account_name'] as String;
    final balance = map['account_balance'] as double;
    final monthlyIncome = map['monthly_income'] as double;
    final monthlyExpense = map['monthly_expense'] as double;

    return AccountModel(
        accountId: id,
        accountName: name,
        balance: balance,
        monthlyIncome: monthlyIncome,
        monthlyExpesne: monthlyExpense);
  }
}
