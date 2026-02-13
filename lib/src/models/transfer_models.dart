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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'transferId': transferId,
      'amount': amount,
      'currency': currency,
      'channel': channel,
      'country': country,
      'recipient': recipient.toJson(),
    };

    if (description != null) data['description'] = description;
    if (metadata != null) data['metadata'] = metadata;

    return data;
  }
}

/// Réponse d'initiation de transfert.
/// L'API peut renvoyer directement les champs ou { success, data: {...} }
class TransferInitiateResponse {
  final bool? success;
  final Transfer? data;

  TransferInitiateResponse({this.success, this.data});

  factory TransferInitiateResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] is Map<String, dynamic>) {
      return TransferInitiateResponse(
        success: json['success'] as bool?,
        data: Transfer.fromJson(json['data'] as Map<String, dynamic>),
      );
    }

    // fallback: la réponse est déjà au format Transfer
    return TransferInitiateResponse(
      success: json['success'] as bool?,
      data: Transfer.fromJson(json),
    );
  }
}

class Transfer {
  final String? transferId;
  final String? status;
  final num? amount;
  final String? currency;
  final String? channel;
  final String? country;
  final Recipient? recipient;
  final String? description;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transfer({
    this.transferId,
    this.status,
    this.amount,
    this.currency,
    this.channel,
    this.country,
    this.recipient,
    this.description,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      transferId: json['transferId']?.toString(),
      status: json['status']?.toString(),
      amount: json['amount'] as num?,
      currency: json['currency']?.toString(),
      channel: json['channel']?.toString(),
      country: json['country']?.toString(),
      recipient: json['recipient'] is Map<String, dynamic>
          ? Recipient.fromJson(json['recipient'] as Map<String, dynamic>)
          : null,
      description: json['description']?.toString(),
      metadata: json['metadata'] is Map<String, dynamic>
          ? (json['metadata'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }
}
