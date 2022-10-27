class BuyersModel {
  int? buyerId;
  final String buyerName;

  BuyersModel({
    required this.buyerName,
    this.buyerId,
  });

  static BuyersModel fromMap(Map<String, Object?> map) {
    final id = map['buyer_id'] as int;
    final name = map['buyer_name'] as String;

    return BuyersModel(
      buyerName: name,
      buyerId: id,
    );
  }
}
