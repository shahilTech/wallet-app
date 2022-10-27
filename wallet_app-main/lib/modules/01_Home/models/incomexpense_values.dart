class IncomeValues {
  final int accountId;
  final double incomeAmount;
  double sumAmount;
  IncomeValues({
    required this.accountId,
    required this.incomeAmount,
    required this.sumAmount,
  });

  static IncomeValues fromMap(Map<String, Object?> map) {
    final accountId = map['account_id'] as int;

    final incomeAmount = map['amount'] as double;
    final sumAmount = map['SUM(amount)'] as double;

    return IncomeValues(
        accountId: accountId, incomeAmount: incomeAmount, sumAmount: sumAmount);
  }
}

class ExpenseValues {
  final int accountId;
  final double expenseAmount;
  double sumAmount;
  ExpenseValues({
    required this.accountId,
    required this.expenseAmount,
    required this.sumAmount,
  });

  static ExpenseValues fromMap(Map<String, Object?> map) {
    final accountId = map['account_id'] as int;

    final expenseAmount = map['amount'] as double;
    final sumAmount = map['SUM(amount)'] as double;
    return ExpenseValues(
        accountId: accountId,
        expenseAmount: expenseAmount,
        sumAmount: sumAmount);
  }
}
