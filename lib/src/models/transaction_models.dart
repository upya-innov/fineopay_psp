class Transaction {
  final String? transactionId;
  final String? transactionType; // payment | transfer
  final String? status;
  final num? amount;
  final String? currency;
  final String? country;
  final String? channel;
  final String? createdAt;
  final String? updatedAt;

  Transaction({
    this.transactionId,
    this.transactionType,
    this.status,
    this.amount,
    this.currency,
    this.country,
    this.channel,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json['transactionId'] as String?,
        transactionType: json['transactionType'] as String?,
        status: json['status'] as String?,
        amount: json['amount'] as num?,
        currency: json['currency'] as String?,
        country: json['country'] as String?,
        channel: json['channel'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );
}
