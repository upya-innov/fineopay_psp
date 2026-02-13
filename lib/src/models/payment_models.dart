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
  final bool success;
  final String transactionId;
  final String? reference; // optionnel si pas renvoyé
  final String merchantReference;
  final String status;
  final num amount;
  final String currency;
  final String environment;

  /// ✅ L’API renvoie un OBJECT ici (pas une liste)
  /// ex: {"method":"otp","data":"https://.../validate"}
  final Map<String, dynamic>? validationData;

  final DateTime? createdAt;

  PaymentInitiateResponse({
    required this.success,
    required this.transactionId,
    this.reference,
    required this.merchantReference,
    required this.status,
    required this.amount,
    required this.currency,
    required this.environment,
    this.validationData,
    this.createdAt,
  });

  factory PaymentInitiateResponse.fromJson(Map<String, dynamic> json) {
    final vd = json['validationData'];

    Map<String, dynamic>? parsedVd;
    if (vd is Map) {
      parsedVd = Map<String, dynamic>.from(vd);
    } else {
      parsedVd = null;
    }

    return PaymentInitiateResponse(
      success: json['success'] == true,
      transactionId: (json['transactionId'] ?? '').toString(),
      reference: json['reference']?.toString(),
      merchantReference: (json['merchantReference'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      amount: json['amount'] is num
          ? (json['amount'] as num)
          : num.tryParse('${json['amount']}') ?? 0,
      currency: (json['currency'] ?? '').toString(),
      environment: (json['environment'] ?? '').toString(),
      validationData: parsedVd,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  /// ✅ URL de validation OTP (si présent)
  String? get validationUrl {
    final data = validationData?['data'];
    if (data is String &&
        (data.startsWith('http://') || data.startsWith('https://'))) {
      return data;
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'transactionId': transactionId,
        if (reference != null) 'reference': reference,
        'merchantReference': merchantReference,
        'status': status,
        'amount': amount,
        'currency': currency,
        'environment': environment,
        'validationData': validationData,
        'createdAt': createdAt?.toIso8601String(),
      };
}



