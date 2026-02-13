import 'customer.dart';

/// ===============================
/// PAYMENT INITIATE REQUEST
/// ===============================

class PaymentInitiateRequest {
  final String merchantReference;
  final num amount;
  final String currency;
  final String channel;
  final String country;
  final Customer customer;
  final String? description;
  final Map<String, dynamic>? metadata;

  final String workflow; // "otp" | "in_app"
  final String? otp;

  final String? successRedirectUrl;
  final String? failedRedirectUrl;

  PaymentInitiateRequest({
    required this.merchantReference,
    required this.amount,
    required this.currency,
    required this.channel,
    required this.country,
    required this.customer,
    this.description,
    this.metadata,
    required this.workflow,
    this.otp,
    this.successRedirectUrl,
    this.failedRedirectUrl,
  });

  /// OTP FLOW
  factory PaymentInitiateRequest.otp({
    required String merchantReference,
    required num amount,
    required String currency,
    required String channel,
    required String country,
    required Customer customer,
    String? description,
    Map<String, dynamic>? metadata,
    String? otp,
  }) {
    return PaymentInitiateRequest(
      merchantReference: merchantReference,
      amount: amount,
      currency: currency,
      channel: channel,
      country: country,
      customer: customer,
      description: description,
      metadata: metadata,
      workflow: 'otp',
      otp: otp ?? '',
    );
  }

  /// IN-APP FLOW
  factory PaymentInitiateRequest.inApp({
    required String merchantReference,
    required num amount,
    required String currency,
    required String channel,
    required String country,
    required Customer customer,
    required String successRedirectUrl,
    required String failedRedirectUrl,
    String? description,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentInitiateRequest(
      merchantReference: merchantReference,
      amount: amount,
      currency: currency,
      channel: channel,
      country: country,
      customer: customer,
      description: description,
      metadata: metadata,
      workflow: 'in_app',
      successRedirectUrl: successRedirectUrl,
      failedRedirectUrl: failedRedirectUrl,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'merchantReference': merchantReference,
      'amount': amount,
      'currency': currency,
      'channel': channel,
      'country': country,
      'customer': customer.toJson(),
      'workflow': workflow,
    };

    if (description != null) data['description'] = description;
    if (metadata != null) data['metadata'] = metadata;

    if (workflow == 'otp') {
      data['otp'] = otp ?? '';
    }

    if (workflow == 'in_app') {
      if (successRedirectUrl != null) {
        data['successRedirectUrl'] = successRedirectUrl;
      }
      if (failedRedirectUrl != null) {
        data['failedRedirectUrl'] = failedRedirectUrl;
      }
    }

    return data;
  }
}

/// ===============================
/// PAYMENT INITIATE RESPONSE
/// ===============================

class PaymentInitiateResponse {
  final bool? success;
  final String? transactionId;
  final String? reference;
  final String? merchantReference;
  final String? status;
  final num? amount;
  final String? currency;
  final String? environment;
  final String? partner;
  final String? partnerTransactionId;
  final List<Map<String, dynamic>>? validationData;
  final DateTime? createdAt;

  PaymentInitiateResponse({
    this.success,
    this.transactionId,
    this.reference,
    this.merchantReference,
    this.status,
    this.amount,
    this.currency,
    this.environment,
    this.partner,
    this.partnerTransactionId,
    this.validationData,
    this.createdAt,
  });

  factory PaymentInitiateResponse.fromJson(Map<String, dynamic> json) {
    // L'API peut renvoyer directement les champs
    // ou { success, data: {...} }
    final payload = (json['data'] is Map<String, dynamic>)
        ? (json['data'] as Map<String, dynamic>)
        : json;

    return PaymentInitiateResponse(
      success: json['success'] as bool? ?? payload['success'] as bool?,
      transactionId: payload['transactionId']?.toString(),
      reference: payload['reference']?.toString(),
      merchantReference: payload['merchantReference']?.toString(),
      status: payload['status']?.toString(),
      amount: payload['amount'] as num?,
      currency: payload['currency']?.toString(),
      environment: payload['environment']?.toString(),
      partner: payload['partner']?.toString(),
      partnerTransactionId: payload['partnerTransactionId']?.toString(),
validationData: (payload['validationData'] is List)
    ? (payload['validationData'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList()
    : null,

      createdAt: payload['createdAt'] != null
          ? DateTime.tryParse(payload['createdAt'].toString())
          : null,
    );
  }
}
