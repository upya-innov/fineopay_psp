import 'recipient.dart';

class TransferInitiateRequest {
  final String transferId;
  final num amount;
  final String currency;
  final String channel;
  final String country;
  final Recipient recipient;
  final String? description;
  final Map<String, dynamic>? metadata;

  TransferInitiateRequest({
    required this.transferId,
    required this.amount,
    required this.currency,
    required this.channel,
    required this.country,
    required this.recipient,
    this.description,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'transferId': transferId,
        'amount': amount,
        'currency': currency,
        'channel': channel,
        'country': country,
        'recipient': recipient.toJson(),
        if (description != null) 'description': description,
        if (metadata != null) 'metadata': metadata,
      };
}
